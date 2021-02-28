//
//  BaseNavigationController.swift
//  YoutubeDemo
//
//  Created by Zih-Siang Yue on 2021/2/28.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override var preferredStatusBarStyle : UIStatusBarStyle {
        
        if let topVC = viewControllers.last {
            //return the status property of each VC, look at step 2
            return topVC.preferredStatusBarStyle
        }
        
        return .default
    }
}
