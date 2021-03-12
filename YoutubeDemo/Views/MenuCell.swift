//
//  MenuCell.swift
//  YoutubeDemo
//
//  Created by Zih-Siang Yue on 2021/2/28.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    let imgView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imgView.tintColor = isHighlighted ? .white : UIColor.rgb(r: 91, g: 14, b: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imgView.tintColor = isSelected ? .white : UIColor.rgb(r: 91, g: 14, b: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(imgView)
        addConstraint(with: "H:[v0(28)]", views: self.imgView)
        addConstraint(with: "V:[v0(28)]", views: self.imgView)
        
        self.imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

