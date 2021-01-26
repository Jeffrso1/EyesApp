//
//  MovieItemCollectionViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 26/01/21.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {
    
    let movieBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func setupCell(movie: Movie) {
        addSubview(movieBanner)
        
        movieBanner.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieBanner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        movieBanner.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        movieBanner.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        movieBanner.widthAnchor.constraint(equalToConstant: 110).isActive = true
        movieBanner.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        imageLoader.loadAsyncPosterImage(from: movie) { image in
            self.movieBanner.image = image
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
