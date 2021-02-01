//
//  HeaderHomeTableViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 26/01/21.
//

import UIKit

class HeaderHomeTableViewCell: UITableViewCell {

    var movie: Movie?
    
    let gradient = CAGradientLayer()
    
    var mainViewController = UIViewController()
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    let movieHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let movieName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.sizeToFit()
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let timeAndGenre: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let movieOverview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textAlignment = .justified
        return label
    }()
    
    let movieDetails: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(NSLocalizedString("Learn More", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.darkText, for: .normal)
        
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = true
        
        
        return button
    }()
    
    @objc func learnMore(sender: UIButton!) {
        
        let nextScene = MovieDetailsViewController2()
        
        //Passa o filme para a variável "movie" da MovieDetailsViewController
        nextScene.movie = movie
  
        self.mainViewController.navigationController?.pushViewController(nextScene, animated: true)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(movie: Movie) {
        
        contentView.addSubview(movieHeader)
        contentView.addSubview(movieDetails)
        movieHeader.addSubview(movieName)
        movieHeader.addSubview(timeAndGenre)
        movieHeader.addSubview(movieOverview)
        
        //self.movieHeader.image = UIImage(named: "wait")
        
        imageLoader.loadAsyncImage(from: movie) { image in
            
           self.movieHeader.image = image
            
        }
        
        movieDetails.addTarget(self, action: #selector(learnMore), for: .touchUpInside)
        
        setupMovieName(movie: movie)
        setupTimeAndGenre(movie: movie)
        setupMovieOverview(movie: movie)
        setupConstraints()
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    func setupMovieName(movie: Movie) {
       
        movieName.text = movie.title
        movieName.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        
    }
    
    func setupMovieOverview(movie: Movie) {
        
        movieOverview.text = movie.overview
        movieOverview.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
    }
    
    func setupTimeAndGenre(movie: Movie) {
        
        timeAndGenre.text = "\(movie.durationText) • \(movie.genreText)"
        timeAndGenre.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    
    // MARK: - Constraints
    func setupConstraints() {
        
        let height = UIScreen.main.bounds.height
        
        let headerHeight = height/2 + 150
        
        sharedConstraints.append(contentsOf: [
        
            movieHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieHeader.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieName.bottomAnchor.constraint(equalTo: timeAndGenre.topAnchor, constant: -5),
            timeAndGenre.bottomAnchor.constraint(equalTo: movieOverview.topAnchor, constant: -10),
            movieHeader.heightAnchor.constraint(equalToConstant: headerHeight),
            
        ])
        
        regularConstraints.append(contentsOf: [
        
            movieHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieName.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 70),
            movieName.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeAndGenre.leadingAnchor.constraint(equalTo: movieName.leadingAnchor),
            movieOverview.leadingAnchor.constraint(equalTo: movieName.leadingAnchor),
            movieOverview.trailingAnchor.constraint(equalTo:centerXAnchor),
            movieOverview.bottomAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: -15),
            movieDetails.heightAnchor.constraint(equalToConstant: 50),
            movieDetails.leadingAnchor.constraint(equalTo: movieHeader.centerXAnchor, constant: 80),
            movieDetails.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -20),
            movieDetails.bottomAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: -15)
            
        ])
        
        compactConstraints.append(contentsOf: [
        
            movieHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieName.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            movieName.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            timeAndGenre.centerXAnchor.constraint(equalTo: movieName.centerXAnchor),
            movieOverview.centerXAnchor.constraint(equalTo: movieName.centerXAnchor),
            movieOverview.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
            movieOverview.bottomAnchor.constraint(equalTo: movieDetails.topAnchor, constant: -20),
            movieOverview.trailingAnchor.constraint(equalTo:contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
            movieDetails.heightAnchor.constraint(equalToConstant: 50),
            movieDetails.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
            movieDetails.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
            movieDetails.bottomAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: -10)
    
        ])
        
        
        //Configurações referentes ao gradiente do MovieHeader
        
        let view = UIView(frame: movieHeader.bounds)
        
        let clearColor = UIColor.black.withAlphaComponent(0.2)
        
        gradient.frame.size.height = headerHeight
        
        gradient.frame.size.width = UIScreen.main.bounds.width + 20
        
        gradient.colors = [clearColor.cgColor, UIColor.backgroundColor().cgColor]
        
        gradient.locations = [0.0, 1.0]
        
        view.layer.insertSublayer(gradient, at: 0)
        
        movieHeader.addSubview(view)
        movieHeader.bringSubviewToFront(view)
        movieHeader.bringSubviewToFront(movieName)
        movieHeader.bringSubviewToFront(timeAndGenre)
        movieHeader.bringSubviewToFront(movieOverview)
        movieHeader.bringSubviewToFront(movieDetails)
    
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
            movieOverview.numberOfLines = 2
            movieName.textAlignment = .center
            
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
            movieName.textAlignment = .left
        }
    }
    
    //Checks whether trait collection (layout) has changed.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
        
    }
    
    
    
    
}


