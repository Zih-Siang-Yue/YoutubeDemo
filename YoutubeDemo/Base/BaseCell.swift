//
//  BaseCell.swift
//  YoutubeDemo
//
//  Created by Zih-Siang Yue on 2021/2/28.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    //When collectionView delegate datasource called the func 'dequeueReusableCell', this func will be triggered.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
