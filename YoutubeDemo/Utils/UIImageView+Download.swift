//
//  UIImageView+Download.swift
//  YoutubeDemo
//
//  Created by Sean.Yue on 2021/3/1.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

extension UIImageView {
    // Ugly way to download image and set up
    func loadImage(by urlStr: String?) {
        if let urlStr = urlStr,
           let url = URL(string: urlStr) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    print("img download failure: \(String(describing: err))")
                    return
                }
                
                DispatchQueue.main.async { [unowned self] in
                    self.image = UIImage(data: data!)
                }
            }
            task.resume()
        }
    }
    
    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let link = link,
              let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }

    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
}
