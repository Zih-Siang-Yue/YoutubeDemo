//
//  UIImageView+Download.swift
//  YoutubeDemo
//
//  Created by Sean.Yue on 2021/3/1.
//  Copyright © 2021 Zih-Siang Yue. All rights reserved.
//

import UIKit

let imageCache: NSCache<NSString, UIImage> = NSCache()

class CustomImageView: UIImageView {
    
    var imageUrlStr: String?
    
    func loadImage(by urlStr: String?) {
        imageUrlStr = urlStr
        
        if let urlStr = urlStr,
           let url = URL(string: urlStr) {
            
            image = nil
            
            if let imageFromCache = imageCache.object(forKey: NSString(string: urlStr)) {
                self.image = imageFromCache
                return
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    print("img download failure: \(String(describing: err))")
                    return
                }
                
                DispatchQueue.main.async { [unowned self] in
                    let imageToCache = UIImage(data: data!)
                    if self.imageUrlStr == urlStr {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache!, forKey: NSString(string: urlStr))
                }
            }
            task.resume()
        }
    }
}

extension UIImageView {
    /*TODO:(Sean) 仍須優化
     1. 需要帶入str 當作key存進 cache裡面
     2. 需要傳入str 以方便做比對, 以免在cell dequeueReuse的時候 資料後面才回來, 但已經被其他cell 復用設定圖片上去之後又再因為回來的圖片更改成錯的圖片
     */
    
    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let link = link,
              let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }

    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        image = nil
        
//        if let imageFromCache = imageCache.object(forKey: NSString(string: urlStr)) {
//            self.image = imageFromCache
//            return
//        }


        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() { [weak self] in
//                imageCache.setObject(image, forKey: NSString(string: urlStr))
                self?.image = image
            }
        }.resume()
    }
    
}
