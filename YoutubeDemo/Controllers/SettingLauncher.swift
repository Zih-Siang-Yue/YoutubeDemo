//
//  SettingLauncher.swift
//  YoutubeDemo
//
//  Created by Sean.Yue on 2021/3/4.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

protocol SettingPresentable: NSObject {
    func presentSettingVC(with setting: Setting)
}


struct Setting {
    let name: String
    let imageName: String
}

class SettingLauncher: NSObject {
    
    let blackView = UIView()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        let setting = Setting(name: "Settings", imageName: "gear")
        let policy = Setting(name: "Terms & privacy policy", imageName: "lock")
        let feedback = Setting(name: "Send Feedback", imageName: "feedback")
        let help = Setting(name: "Help", imageName: "info")
        let acc = Setting(name: "Switch Account", imageName: "user")
        let cancel = Setting(name: "Cancel", imageName: "cancel")
        return [setting, policy, feedback, help, acc, cancel]
    }()
    
    var delegate: SettingPresentable?
    
    override init() {
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(SettingCell.self, forCellWithReuseIdentifier: self.cellId)
    }

    func showSettings() {
        //show menu
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
            blackView.addGestureRecognizer(tap)
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let height: CGFloat = cellHeight * CGFloat(settings.count)
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
    }
    
    @objc func handleDismiss() {
        //將下面的code 用didSelected 裡面的code 取代
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
}

extension SettingLauncher: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Step1: revise the method handleDismiss()
        //Step2: make a delegate with HomeVC, and in the section completion call the delegate method(with parameters) to present a new vc
        //Step3: handle what contents should be presented in new vc
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.handleDismiss()
        } completion: { (completed) in
            let setting = self.settings[indexPath.item]
            if setting.name != "" && setting.name != "Cancel" {
                self.delegate?.presentSettingVC(with: setting)
            }
            
        }

    }
}
