//
//  Images.swift
//  Eyes
//
//  Created by Lucas Frazão on 22/10/20.
//

import UIKit
import Foundation


let imageLoader = Images()

class Images {

     func loadAsyncImage(from movie: Movie, then completion: @escaping (UIImage)->Void) {
        
        if let url = movie.backdropURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    movie.imageBackdropData = data
                    DispatchQueue.main.async {
                        if let currentImage = UIImage(data: data) {
                            completion(currentImage)
                        }
                    }
                }
            }
        }
    }
    
     func loadAsyncPosterImage(from movie: Movie, then completion: @escaping (UIImage)->Void) {
        
        if let url = movie.posterURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    movie.imageData = data
                    DispatchQueue.main.async {
                        if let currentImage = UIImage(data: data) {
                            completion(currentImage)
                        }
                    }
                }
            }
        }
    }

    
    
    
    
}
