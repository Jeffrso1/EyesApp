//
//  CastTableViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 03/11/20.
//

import UIKit

class CastCVCell: UICollectionViewCell {
    
    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var characterName: UILabel!
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        castImage.layer.borderWidth = 2
        castImage.layer.borderColor = UIColor.white.cgColor
        castImage.layer.masksToBounds = false
        castImage.layer.cornerRadius = castImage.frame.size.width / 2
        castImage.clipsToBounds = true

    }
        
    func setupCastCell(indexPath: IndexPath, movie: Movie) {
        
        if movie.cast?.count != 0 {
        
        castName.text = movie.cast?[indexPath.row].name ?? "Cast Name Not Available"
        characterName.text = movie.cast?[indexPath.row].character ?? "Character Name Not Available"

        loadAsyncImage(from: (movie.cast![indexPath.row])) { image in
      
            self.castImage.image = image
            
        }
            
        }
        
    }
    
    fileprivate func loadAsyncImage(from movie: MovieCast, then completion: @escaping (UIImage)->Void) {
        if let data = movie.profileImageData {
            if let currentImage = UIImage(data: data) {
                completion(currentImage)
            }
        }
        else if let url = movie.profileURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    movie.profileImageData = data
                    DispatchQueue.main.async {
                        if let currentImage = UIImage(data: data) {
                            completion(currentImage)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        if let currentImage = UIImage(named: "wait") {
                            completion(currentImage)
                        }
                    }
                }
            }
        }
    }
    
    
}
