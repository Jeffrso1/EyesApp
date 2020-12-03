//
//  FavoritesCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 02/12/20.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    
    let movieBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func setupCell(movie: Movie, check isImageLoaded: Bool) {
        addSubview(movieBanner)
        
        movieBanner.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        movieBanner.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        movieBanner.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        movieBanner.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        if isImageLoaded == true {
            loadAsyncImage(from: movie) { image in
                self.movieBanner.image = image
            }
        } else {
            movieBanner.image = UIImage(named: "wait")
        }
        
        movieBanner.layer.borderWidth = 0.8
        movieBanner.layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func loadAsyncImage(from movie: Movie, then completion: @escaping (UIImage)->Void) {
        if let data = movie.imageData {
            if let currentImage = UIImage(data: data) {
                completion(currentImage)
            }
        }
        else if let url = movie.posterURL {
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
