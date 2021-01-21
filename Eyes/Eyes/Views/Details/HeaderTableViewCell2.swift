//
//  HeaderTableViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit
import SafariServices

class HeaderTableViewCell2: UITableViewCell, SFSafariViewControllerDelegate {

    let movieHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeAndGenre: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let watchTrailer: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let reviewMovie: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var movie: Movie?
    
    var delegate: MovieReviewDelegate!
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func checkMovieTrailer() throws {
        
        if dao.selectedMovie!.youtubeTrailers?.count == 0 {
           
            throw MovieDetailError.trailerNotAvailable
        
        } else {
        
            let safariVC = SFSafariViewController(url: (dao.selectedMovie!.youtubeTrailers?.first?.youtubeURL)!)
        safariVC.delegate = self
        safariVC.modalPresentationStyle = .pageSheet
        
        haptic.setupImpactHaptic(style: .light)
        
        self.window?.rootViewController?.present(safariVC, animated: true, completion: nil)
        }
    }
    
    @objc func watchTrailerWasPressed(sender: UIButton!) {
        do {
            
        try checkMovieTrailer()
        
            
        } catch MovieDetailError.trailerNotAvailable {
        
            Alert.showBasic(title: NSLocalizedString("Movie Trailer Not Available", comment: ""), message: NSLocalizedString("Please, try again later.", comment: ""), vc: (self.window?.rootViewController)!, type: .error)
            
        } catch {
            Alert.showBasic(title: NSLocalizedString("There was a problem loading this movie.", comment: ""), message: NSLocalizedString("Please, try again later.", comment: ""), vc: (self.window?.rootViewController)!, type: .error)
        }
        
    }
    
    @objc func reviewMovieWasPressed(sender: UIButton!) {
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.callSegueFromCell(dataObject: movie!)
        }
        
        haptic.setupImpactHaptic(style: .light)
    }
    
    func setupCell(movie: Movie) {
//        self.movie = movie
        self.backgroundColor = UIColor.backgroundColor()
        
        contentView.addSubview(movieHeader)
        contentView.addSubview(movieBanner)
        contentView.addSubview(movieName)
        contentView.addSubview(timeAndGenre)
        contentView.addSubview(watchTrailer)
        contentView.addSubview(reviewMovie)
        
        watchTrailer.addTarget(self, action: #selector(watchTrailerWasPressed), for: .touchUpInside)
        reviewMovie.addTarget(self, action: #selector(reviewMovieWasPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            movieHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieHeader.heightAnchor.constraint(equalToConstant: 281),
            movieHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -5),
            movieHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            
            movieBanner.widthAnchor.constraint(equalToConstant: 146),
            movieBanner.centerXAnchor.constraint(equalTo: movieHeader.centerXAnchor),
            movieBanner.heightAnchor.constraint(equalToConstant: 212),
            movieBanner.topAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: -186),
            movieBanner.widthAnchor.constraint(equalTo: movieBanner.heightAnchor, multiplier: 0.68867925),
            
            movieName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            movieName.heightAnchor.constraint(equalToConstant: 33),
            movieName.topAnchor.constraint(equalTo: movieBanner.bottomAnchor, constant: 2),
            
            timeAndGenre.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeAndGenre.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            timeAndGenre.heightAnchor.constraint(equalToConstant: 25),
            timeAndGenre.topAnchor.constraint(equalTo: movieName.bottomAnchor),
            
            watchTrailer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            watchTrailer.trailingAnchor.constraint(equalTo: reviewMovie.leadingAnchor, constant: -34),
            watchTrailer.widthAnchor.constraint(equalTo: reviewMovie.widthAnchor),
            watchTrailer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19),
            watchTrailer.heightAnchor.constraint(equalToConstant: 50),
            watchTrailer.centerYAnchor.constraint(equalTo: reviewMovie.centerYAnchor),
            watchTrailer.topAnchor.constraint(equalTo: timeAndGenre.bottomAnchor, constant: 20),
            
            reviewMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            reviewMovie.heightAnchor.constraint(equalTo: watchTrailer.heightAnchor)
            
        ])
        
        movieBanner.image = UIImage(named: "wait")
        
        imageLoader.loadAsyncPosterImage(from: movie) { image in
            self.movieBanner.image = image
        }
        
        movieHeader.image = UIImage(named: "wait")
        imageLoader.loadAsyncImage(from: movie) { image in
            self.movieHeader.image = image
        }
        
        movieBanner.layer.cornerRadius = 7
        movieBanner.clipsToBounds = true
        movieBanner.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 0.8)
        
        movieName.text = movie.title
        movieName.textAlignment = .center
        movieName.font = UIFont.boldSystemFont(ofSize: 27)
        
        timeAndGenre.text = movie.durationText + " • " + movie.genreText
        
        timeAndGenre.textAlignment = .center
        timeAndGenre.font = UIFont.systemFont(ofSize: 16)
        
        watchTrailer.backgroundColor = UIColor.accentColor()
        setupButtonFeatures(button: watchTrailer, withLabel: "Watch Trailer")
        
        reviewMovie.backgroundColor = UIColor.accentColor()
        setupButtonFeatures(button: reviewMovie, withLabel: "Review Movie")
    }
    
    func setupButtonFeatures(button: UIButton, withLabel label: String) {
        button.setTitle(label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.cornerRadius = 7
    }
}
