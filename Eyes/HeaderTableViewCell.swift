//
//  HeaderCollectionViewCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 28/10/20.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
   
    @IBOutlet weak var movieHeader: UIImageView!
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var timeAndGenre: UILabel!
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    func setupHeaderCell() {
        movieBanner.image = UIImage(data: (currentMovie?.imageData)!)
        movieBanner.layer.cornerRadius = 7
        movieBanner.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 0.8)
        movieBanner.layer.borderWidth = 2
        movieBanner.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        movieBanner.layer.shadowOffset = CGSize(width: 0, height: 0)
        movieBanner.layer.shadowRadius = 10
        movieTitle.text = currentMovie?.title
        timeAndGenre.text = currentMovie!.durationText + " • " + currentMovie!.genreText
        
        loadAsyncImage(from: currentMovie!) { image in
            self.movieHeader.image = image
        }
    }
    
    fileprivate func loadAsyncImage(from movie: Movie, then completion: @escaping (UIImage)->Void) {
        
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
}
