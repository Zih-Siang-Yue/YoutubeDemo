//
//  SettingCell.swift
//  YoutubeDemo
//
//  Created by Sean.Yue on 2021/3/8.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            iconImgView.tintColor = isHighlighted ? .white: .darkGray
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "gear")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    var setting: Setting? {
        didSet {
            if let setting = setting {
                nameLabel.text = setting.name
                iconImgView.image = UIImage(named: setting.imageName)?.withRenderingMode(.alwaysTemplate)
                iconImgView.tintColor = .darkGray
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImgView)
        
        addConstraint(with: "H:|-8-[v0(24)]-8-[v1]|", views: iconImgView, nameLabel)
        addConstraint(with: "V:|[v0]|", views: nameLabel)
        addConstraint(with: "V:[v0(24)]", views: iconImgView)
        iconImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
