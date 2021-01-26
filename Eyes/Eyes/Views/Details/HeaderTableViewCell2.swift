//
//  HeaderTableViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit
import SafariServices

class HeaderTableViewCell2: UITableViewCell, SFSafariViewControllerDelegate {
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    let gradient = CAGradientLayer()
    
    var mainViewController = UIViewController()
    
    let movieHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        label.numberOfLines = 2
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
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        return button
    }()
    
    let reviewMovie: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
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
        
        if movie!.youtubeTrailers?.count == 0 {
            
            throw MovieDetailError.trailerNotAvailable
            
        } else {
            
            /*
            Essa lógica tem objetivo verificar se a variável "movie" contém os componentes necessários para que seja mostrado o filme, caso não, será utilizada a variável "dao.selectedMovie" que armazena o filme que foi buscado.
             
             Podemos melhorá-la. No momento, resolve o problema.
            */
            
            if movie!.youtubeTrailers?.first?.youtubeURL != nil {
                
                let safariVC = SFSafariViewController(url: (movie!.youtubeTrailers?.first?.youtubeURL)!)
                safariVC.delegate = self
                safariVC.modalPresentationStyle = .pageSheet
                
                self.window?.rootViewController?.present(safariVC, animated: true, completion: nil)
                
            } else {
                
                let safariVC = SFSafariViewController(url: (dao.selectedMovie!.youtubeTrailers?.first?.youtubeURL)!)
                safariVC.delegate = self
                safariVC.modalPresentationStyle = .pageSheet
                
                self.window?.rootViewController?.present(safariVC, animated: true, completion: nil)
            }
            
            
        }
        
        
        haptic.setupImpactHaptic(style: .light)
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nextScene = storyboard.instantiateViewController(withIdentifier: "BechdelTestViewController") as! BechdelTestViewController
    
        //Passa o filme para a variável "movie" da MovieDetailsViewController
        nextScene.movie = movie
        
        self.mainViewController.navigationController?.pushViewController(nextScene, animated: true)
        
        haptic.setupImpactHaptic(style: .light)
    }
    
    func setupCell(movie: Movie) {
        
        self.movie = movie
        self.backgroundColor = UIColor.backgroundColor()
        
        let radius: CGFloat = 7

        movieBanner.clipsToBounds = true
        movieBanner.layer.cornerRadius = radius
        movieBanner.contentMode = .scaleAspectFill
    
        let roundedView = UIView()
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOffset = CGSize(width: 0, height: -20)
        roundedView.layer.shadowOpacity = 0.8
        roundedView.layer.shadowRadius = 40
        
        roundedView.addSubview(movieBanner)
        contentView.addSubview(movieHeader)
        contentView.addSubview(roundedView)
        contentView.addSubview(movieName)
        contentView.addSubview(timeAndGenre)
        contentView.addSubview(watchTrailer)
        contentView.addSubview(reviewMovie)
        
        watchTrailer.addTarget(self, action: #selector(watchTrailerWasPressed), for: .touchUpInside)
        reviewMovie.addTarget(self, action: #selector(reviewMovieWasPressed), for: .touchUpInside)
        
        let movieHeaderHeightCompact = movieHeader.heightAnchor.constraint(equalToConstant: 281)
        
        let movieNameTrailing = movieName.trailingAnchor.constraint(lessThanOrEqualTo: centerXAnchor)
        movieNameTrailing.priority = UILayoutPriority(999)
        
        sharedConstraints.append(contentsOf: [
               
            movieHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieBanner.widthAnchor.constraint(equalTo: movieBanner.heightAnchor, multiplier: 0.68867925),
            watchTrailer.heightAnchor.constraint(equalToConstant: 50),
            reviewMovie.heightAnchor.constraint(equalTo: watchTrailer.heightAnchor),
            watchTrailer.widthAnchor.constraint(equalTo: reviewMovie.widthAnchor),
            
        ])
        
        regularConstraints.append(contentsOf: [
                                
            movieHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            movieBanner.widthAnchor.constraint(equalToConstant: 164),
            movieBanner.heightAnchor.constraint(equalToConstant: 230),
            movieBanner.topAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: -200),
            movieBanner.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            movieBanner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            movieName.leadingAnchor.constraint(equalTo: movieBanner.trailingAnchor, constant: 20),
            movieName.bottomAnchor.constraint(equalTo: timeAndGenre.topAnchor, constant: -5),
            movieNameTrailing,
            
            timeAndGenre.leadingAnchor.constraint(equalTo: movieName.leadingAnchor),
            timeAndGenre.bottomAnchor.constraint(equalTo: movieBanner.bottomAnchor, constant: -15),
            
            reviewMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            watchTrailer.bottomAnchor.constraint(equalTo: movieBanner.bottomAnchor, constant: -15),
            
            reviewMovie.leadingAnchor.constraint(equalTo: watchTrailer.trailingAnchor, constant: 20),
            reviewMovie.centerYAnchor.constraint(equalTo: watchTrailer.centerYAnchor),
            
            movieHeaderHeightCompact
  
                                    
        ])
        
        compactConstraints.append(contentsOf: [
            
            movieHeaderHeightCompact,
            movieHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            movieBanner.centerXAnchor.constraint(equalTo: movieHeader.centerXAnchor),
            movieBanner.topAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: -186),
            movieBanner.widthAnchor.constraint(equalToConstant: 146),
            movieBanner.heightAnchor.constraint(equalToConstant: 212),
            
            movieName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            movieName.topAnchor.constraint(equalTo: movieBanner.bottomAnchor, constant: 5),
            
            timeAndGenre.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeAndGenre.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            timeAndGenre.topAnchor.constraint(equalTo: movieName.bottomAnchor),
            timeAndGenre.heightAnchor.constraint(equalToConstant: 25),
            
            watchTrailer.topAnchor.constraint(equalTo: timeAndGenre.bottomAnchor, constant: 15),
            
            watchTrailer.centerYAnchor.constraint(equalTo: reviewMovie.centerYAnchor),
            watchTrailer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            watchTrailer.trailingAnchor.constraint(equalTo: reviewMovie.leadingAnchor, constant: -34),
            
            reviewMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            watchTrailer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19),
            
        ])
        
        movieBanner.image = UIImage(named: "wait")
        
        imageLoader.loadAsyncPosterImage(from: movie) { image in
            self.movieBanner.image = image
        }
        
        movieHeader.image = UIImage(named: "wait")
        imageLoader.loadAsyncImage(from: movie) { image in
            self.movieHeader.image = image
        }

        movieName.text = movie.title
        movieName.textAlignment = .center
        movieName.font = UIFont.boldSystemFont(ofSize: 27)
        
        if movie.durationText != "n/a" && movie.genreText != "n/a" {
        
        timeAndGenre.text = movie.durationText + " • " + movie.genreText
            
        } else {
            
        timeAndGenre.text = dao.selectedMovie!.durationText + " • " + dao.selectedMovie!.genreText
            
        }
        
        timeAndGenre.textAlignment = .center
        timeAndGenre.font = UIFont.systemFont(ofSize: 16)
        
        watchTrailer.backgroundColor = UIColor.accentColor()
        setupButtonFeatures(button: watchTrailer, withLabel: "Watch Trailer", withImage: "film")
        
        reviewMovie.backgroundColor = UIColor.accentColor()
        setupButtonFeatures(button: reviewMovie, withLabel: "Review Movie", withImage: "square.and.pencil")
        
        //Configurações referentes ao gradiente do MovieHeader
        
        let view = UIView(frame: movieHeader.bounds)
        
        let clearColor = UIColor.black.withAlphaComponent(0.2)
        
        gradient.frame.size.height = movieHeaderHeightCompact.constant + 4
        
        gradient.frame.size.width = UIScreen.main.bounds.width + 20
        
        gradient.colors = [clearColor.cgColor, UIColor.backgroundColor().cgColor]
        
        gradient.locations = [0.0, 1.0]
        
        view.layer.insertSublayer(gradient, at: 0)
        
        movieHeader.addSubview(view)
        movieHeader.bringSubviewToFront(view)
        
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    func setupButtonFeatures(button: UIButton, withLabel label: String, withImage image: String) {
        button.setTitle(label, for: .normal)
        button.setImage(UIImage(systemName: image), for: .normal)
        button.imageView?.tintColor = .white
        button.imageEdgeInsets.left = -10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.cornerRadius = 7
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
           // activating shared constraints
           NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            // activating compact constraints
            NSLayoutConstraint.activate(compactConstraints)
            
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
            constraintsForiPad()
        }
    }
    
    func constraintsForiPad() {
        
        gradient.frame.size.width = UIScreen.main.bounds.width + 20
        movieName.font = UIFont.boldSystemFont(ofSize: 32)
 
    }
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        layoutTrait(traitCollection: traitCollection)
        
    }
    
}
