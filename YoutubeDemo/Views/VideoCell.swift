//
//  VideoCell.swift
//  YoutubeDemo
//
//  Created by Zih-Siang Yue on 2021/2/27.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var video:  Video? {
        didSet {
            self.titleLabel.text = video?.title
            self.setupImages()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subtitleText = "\(channelName)・\(String(describing: numberFormatter.string(from: numberOfViews)!))・2 years ago"
                self.subtitleTextView.text = subtitleText
            }
            
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 10000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                self.titleLabelConstraint?.constant = estimatedRect.size.height > 20 ? 44 : 20
            }
            
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imgView = CustomImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        return view
    }()
    
    let userProfilerImgView: CustomImageView = {
        let imgView = CustomImageView()
        imgView.layer.cornerRadius = 22
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let txView = UITextView()
        txView.textColor = .lightGray
        txView.translatesAutoresizingMaskIntoConstraints = false
        txView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return txView
    }()
    
    var titleLabelConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(self.thumbnailImageView)
        self.addSubview(self.separatorView)
        self.addSubview(self.userProfilerImgView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleTextView)
        
        self.addConstraint(with: "H:|-16-[v0]-16-|", views: self.thumbnailImageView)
        self.addConstraint(with: "H:|-16-[v0(44)]", views: self.userProfilerImgView)
        self.addConstraint(with: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: self.thumbnailImageView, self.userProfilerImgView, self.separatorView)
        self.addConstraint(with: "H:|[v0]|", views: self.separatorView)
        
        
        self.titleLabel.topAnchor.constraint(equalTo: self.thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.userProfilerImgView.rightAnchor, constant: 8).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.thumbnailImageView.rightAnchor, constant: 0).isActive = true
        self.titleLabelConstraint = self.titleLabel.heightAnchor.constraint(equalToConstant: 44)
        self.titleLabelConstraint?.isActive = true
        
        self.subtitleTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4).isActive = true
        self.subtitleTextView.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.subtitleTextView.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        self.subtitleTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    func setupImages() {
        self.thumbnailImageView.loadImage(by: video?.thumbnailImageName)
        self.userProfilerImgView.loadImage(by: video?.channel?.profilerImageName)
//        self.thumbnailImageView.downloaded(from: video?.thumbnailImageName, contentMode: .scaleAspectFill)
//        self.userProfilerImgView.downloaded(from: video?.channel?.profilerImageName, contentMode: .scaleAspectFill)
    }
}
