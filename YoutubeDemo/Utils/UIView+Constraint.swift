//
//  UIView+Constraint.swift
//  YoutubeDemo
//
//  Created by Zih-Siang Yue on 2021/2/27.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraint(with format: String, views: UIView...) {
        var viewDict: [String: UIView] = [:]
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions() , metrics: nil, views: viewDict))
    }
}
