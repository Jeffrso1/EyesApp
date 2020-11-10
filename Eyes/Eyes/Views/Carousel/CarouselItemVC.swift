//
//  CarouselItemVC.swift
//  Eyes
//
//  Created by Jefferson Silva on 09/11/20.
//

import UIKit

class CarouselItemVC: UIViewController, DAORequester {
    func updated() {
    }
    
    var movieBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var movieBlurHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var movieHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var movieName: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    var timeAndGenre: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    var movieDescription: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isSelectable = false
        
        return textView
    }()
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        movieName.text = movie.title
        movieDescription.text = movie.overview
        timeAndGenre.text = movie.durationText + " • " + movie.genreText
        
        movieBanner.image = UIImage(named: "wait")!
        movieHeader.image = UIImage(named: "wait")!
        
        loadAsyncImage(from: movie) { image in
            self.movieBanner.image = image
            self.movieHeader.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(movieHeader)
        view.addSubview(movieBanner)
        view.addSubview(movieName)
        view.addSubview(timeAndGenre)
        view.addSubview(movieDescription)
        
        setupMovieBanner()
        setupMovieHeader()
        setupMovieName()
        setupTimeAndGenre()
        setupMovieDescription()
        
    }
    
    private func setupMovieBanner() {
        movieBanner.layer.borderWidth = 1
        movieBanner.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        movieBanner.layer.cornerRadius = 5
        movieBanner.clipsToBounds = true
        
        movieBanner.heightAnchor.constraint(equalTo: movieHeader.heightAnchor, multiplier: 0.75).isActive = true
        movieBanner.widthAnchor.constraint(equalTo: movieBanner.heightAnchor, multiplier: 0.71830986).isActive = true
        movieBanner.centerYAnchor.constraint(equalTo: movieHeader.centerYAnchor, constant: 10).isActive = true
        movieBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 112).isActive = true
        
    }
    
    private func setupMovieHeader() {
        
        var height = movieHeader.heightAnchor.constraint(equalToConstant: 350)
        height.priority = UILayoutPriority(250)
        height.isActive = true
        
        movieHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieHeader.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: movieHeader.bounds.height)
        movieHeader.addSubview(blurView)
        
        NSLayoutConstraint.activate([
          blurView.heightAnchor.constraint(equalTo: movieHeader.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: movieHeader.widthAnchor),
          ])
    }
    
    private func setupMovieName() {
        movieName.font = UIFont.boldSystemFont(ofSize: 32)
        
        // Constraints tiradas do Storyboard...
        let height = movieName.heightAnchor.constraint(equalToConstant: 50)
        movieName.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        movieName.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        movieName.numberOfLines = 2
        height.isActive = true
        height.priority = UILayoutPriority(250)
        NSLayoutConstraint(item: movieName, attribute: .top, relatedBy: .equal, toItem: movieHeader, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        
    }
    
    private func setupTimeAndGenre() {
        timeAndGenre.font = UIFont.systemFont(ofSize: 17)
        
        timeAndGenre.leadingAnchor.constraint(equalTo: movieName.leadingAnchor).isActive = true
        timeAndGenre.trailingAnchor.constraint(equalTo: movieName.trailingAnchor).isActive = true
        NSLayoutConstraint(item: timeAndGenre, attribute: .top, relatedBy: .equal, toItem: movieName, attribute: .bottom, multiplier: 1, constant: 3).isActive = true
    }
    
    private func setupMovieDescription() {
        movieDescription.backgroundColor = UIColor(named: "backgroundColor")
        movieDescription.font = UIFont.systemFont(ofSize: 15)
        
        movieDescription.trailingAnchor.constraint(equalTo: movieName.trailingAnchor).isActive = true
        movieDescription.leadingAnchor.constraint(equalTo: movieName.leadingAnchor).isActive = true
        movieDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        NSLayoutConstraint(item: movieDescription, attribute: .top, relatedBy: .equal, toItem: timeAndGenre, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
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
