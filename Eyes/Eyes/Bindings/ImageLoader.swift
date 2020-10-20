//
//  ImageLoader.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

public class ImageLoader {
    
    
    
    //@Published
    var image: UIImage?
    //@Published
    var isLoading = false
    
    var imageCache = _imageCache

    /*
     Loads an image through URL provided by the API. In case of error, handle it properly.
     
     'DispatchQueue.global' is used to make sure the interface doesn't freeze upon loading. This could turn out to be a bad behaviour. Needs more testing!
     
    */
    
    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                    //self?.delegate?.imageLoader(image: image)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
