//
//  FavoritesCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 02/12/20.
//

import UIKit

protocol FavoritesDelegate {
    
    func updateCell()
    
}


class FavoritesCell: UICollectionViewCell, UIContextMenuInteractionDelegate, FavoriteRequester {
 
    var movie: Movie?
    
    var delegate:FavoritesDelegate!
    
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
            imageLoader.loadAsyncPosterImage(from: movie) { image in
                self.movieBanner.image = image
            }
        } else {
            movieBanner.image = UIImage(named: "wait")
        }
        
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)

        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
   func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
       
       return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
        let destruct = UIAction(title: NSLocalizedString("Remove from Favorites", comment: ""), attributes: .destructive) { [self] _ in favorites.removeFavoriteMovie(movie: self.movie!, to: self) }
                
        let items = UIMenu(title: NSLocalizedString("More", comment: ""), options: .displayInline, children: [
            UIAction(title: NSLocalizedString("Go to Details", comment: ""), image: UIImage(systemName: "arrow.uturn.right"), handler: { [self] _ in })
            //UIAction(title: "Item 2", image: UIImage(systemName: "envelope"), handler: { _ in }),
            //UIAction(title: "Item 3", image: UIImage(systemName: "flame.fill"), handler: { _ in }),
            //UIAction(title: "Item 4", image: UIImage(systemName: "video"), state: .on, handler: { _ in })
        ])
        
        self.movieBanner.layer.cornerRadius = 0
        
        return UIMenu(title: "", children: [destruct])
    }
   }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        self.movieBanner.layer.cornerRadius = 7
    }
    
    func favoriteRequester() {
        
        delegate.updateCell()
        
    }

}
