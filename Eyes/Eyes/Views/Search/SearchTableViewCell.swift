//
//  SearchTableViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 30/11/20.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    //@IBOutlet weak var movieTitle: UILabel!
    //@IBOutlet weak var movieGenre: UILabel!
    //@IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    let movieBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        
        return imageView
    }()
    
    var movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 2
        
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //movieBanner.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(movie: Movie) {
        
        addSubview(movieBanner)
        addSubview(movieTitle)
        
        movieBanner.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        movieBanner.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        movieBanner.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        movieBanner.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        movieBanner.widthAnchor.constraint(equalToConstant: 145).isActive = true

        imageLoader.loadAsyncImage(from: movie) { image in
            self.movieBanner.image = image
        }
        
        movieTitle.centerYAnchor.constraint(equalTo: movieBanner.centerYAnchor).isActive = true
        
        self.movieTitle.text = movie.title
        
        movieTitle.leadingAnchor.constraint(equalTo: movieBanner.trailingAnchor, constant: 20).isActive = true
        
        movieTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        
        
   
    }
    
    
    func setupMovieResults(indexPath: IndexPath) {
        
        
        
    }

}
