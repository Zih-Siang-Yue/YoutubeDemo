//
//  ViewController.swift
//  YoutubeDemo
//
//  Created by Zih-Siang Yue on 2021/2/27.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
//    var videos: [Video] = {
//        let kendrickChannel = Channel(name: "KendrickChannel", profilerImageName: "Kendrick")
//        let humbleVideo = Video(thumbnailImageName: "Humble", title: "Kendrick Lamar - HUMBLE", numberOfViews: 769159932, updateDate: nil, channel: kendrickChannel)
//
//        let zomboyChannel = Channel(name: "ZomboyChannel", profilerImageName: "Zomboy")
//        let yAndDVideo = Video(thumbnailImageName: "Young&Dangerous", title: "Zomboy - Young & Dangerous ft. Kato (PARTY THIEVES & Tre Sera Remix)", numberOfViews: 1911593, updateDate: nil, channel: zomboyChannel)
//
//        return [humbleVideo, yAndDVideo]
//    }()
    var videos: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBaseValue()
        self.setupMenuBar()
        self.setupCollectionView()
        self.setupNavBarButtons()
        self.fetchVideo()
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupBaseValue() {
        self.navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.contentMode = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        self.navigationItem.titleView = titleLabel
    }
    
    private func setupMenuBar() {
        view.addSubview(self.menuBar)
        view.addConstraint(with: "H:|[v0]|", views: self.menuBar)
        view.addConstraint(with: "V:|[v0(50)]", views: self.menuBar)
    }
    
    private func setupCollectionView() {
        self.collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        self.collectionView.backgroundColor = .white
        self.collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0) //讓collectionView 不再menuBar 底下
    }
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)  //TODO:(Sean) 改變顏色失敗
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreBarButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))

        self.navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
    }
    
    private func fetchVideo() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, err) in
            if err != nil {
                print("error: \(String(describing: err))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                
                var videoList: [Video] = []
                for dict in json as! [[String: AnyObject]] {
                    guard let thumbnailImageName = dict["thumbnail_image_name"] as? String,
                          let title = dict["title"] as? String,
                          let numberOfViews = dict["number_of_views"] as? NSNumber,
                          let channelDict = dict["channel"] as? [String: AnyObject],
                          let channelName = channelDict["name"] as? String,
                          let channelProfile = channelDict["profile_image_name"] as? String else {
                        return
                    }
                    
                    let video = Video(thumbnailImageName: thumbnailImageName , title: title, numberOfViews: numberOfViews, updateDate: Date(), channel: Channel(name: channelName, profilerImageName: channelProfile))
                    videoList.append(video)
                }
                self.videos = videoList
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch let jsonErr {
                print("json error: \(jsonErr)")
            }
                        
        }
        task.resume()
    }

    //MARK: Action
    @objc func handleSearch() {
        
    }
    
    let settingsLauncher = SettingLauncher()
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    //TODO (Sean): call this method after delegate method will be called
    func presentControllerFor(setting: Setting) {
        let dummyVC = UIViewController()
        dummyVC.view.backgroundColor = .white
        dummyVC.navigationItem.title = setting.name
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white()]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(dummyVC, animated: true)
    }
}

extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 * 2) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
}

