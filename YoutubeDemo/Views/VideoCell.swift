//
//  VideoCell.swift
//  YoutubeDemo
//
//  Created by Zih-Siang Yue on 2021/2/27.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    let thumbnailImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "humble")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        return view
    }()
    
    let userProfilerImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "kendrick")
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 22
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Kendrick Lamar - HUMBLE"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UITextView = {
        let txView = UITextView()
        txView.text = "Kendrick Lamar・768M views・3 years ago"
        txView.textColor = .lightGray
        txView.translatesAutoresizingMaskIntoConstraints = false
        txView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return txView
    }()
    
    //MARK: Init
    //When collectionView delegate datasource called the func 'dequeueReusableCell', this func will be triggered.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        self.addSubview(self.thumbnailImageView)
        self.addSubview(self.separatorView)
        self.addSubview(self.userProfilerImgView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        
        self.addConstraint(with: "H:|-16-[v0]-16-|", views: self.thumbnailImageView)
        self.addConstraint(with: "H:|-16-[v0(44)]", views: self.userProfilerImgView)
        self.addConstraint(with: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: self.thumbnailImageView, self.userProfilerImgView, self.separatorView)
        self.addConstraint(with: "H:|[v0]|", views: self.separatorView)
        
        
        self.titleLabel.topAnchor.constraint(equalTo: self.thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.userProfilerImgView.rightAnchor, constant: 8).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.thumbnailImageView.rightAnchor, constant: 0).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4).isActive = true
        self.subtitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.subtitleLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        self.subtitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        //        self.thumbnailImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        //        self.thumbnailImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        //        self.thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        //        self.thumbnailImageView.bottomAnchor.constraint(equalTo: self.separatorView.topAnchor, constant: -15).isActive = true
        //
        //        self.separatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        //        self.separatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //        self.separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        //        self.separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
    }
    
}
