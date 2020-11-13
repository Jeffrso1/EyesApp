//
//  HeaderCollectionViewCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 28/10/20.
//

import UIKit
import SafariServices

class HeaderTableViewCell: UITableViewCell, SFSafariViewControllerDelegate {
   
    @IBOutlet weak var movieHeader: UIImageView!
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var timeAndGenre: UILabel!
    @IBOutlet weak var watchTrailer: UIButton!
    @IBOutlet weak var seeTMDb: UIButton!
    
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    func setupHeaderCell() {
        
        movieBanner.image = UIImage(data: (currentMovie?.imageData)!)
        movieBanner.layer.cornerRadius = 7
        movieBanner.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 0.8)
        //movieBanner.layer.borderWidth = 2
        movieTitle.text = currentMovie?.title
        
        
        timeAndGenre.text = currentMovie!.durationText + " • " + currentMovie!.genreText
        
        
        let roundedView = UIView()
        roundedView.layer.shadowColor = UIColor.black.cgColor
        roundedView.layer.shadowOffset = CGSize(width: 0, height: 10)
        roundedView.layer.shadowOpacity = 0.8
        roundedView.layer.shadowRadius = 10
        
        //roundedView.addSubview(movieBanner)
        
        loadAsyncImage(from: currentMovie!) { image in
            self.movieHeader.image = image
        }
        
        setupButton(button: watchTrailer)
        setupButton(button: seeTMDb)
        
        self.reloadInputViews()
    }
    
    func setupButton(button: UIButton) {
        
        button.cornerRadius = 7
        
    }
    
    
    @IBAction func watchTrailer(_ sender: Any) {
        
        if currentMovie?.youtubeTrailers?.count != 0 {
        
        let safariVC = SFSafariViewController(url: (currentMovie?.youtubeTrailers?.first?.youtubeURL)!)
        safariVC.delegate = self
        safariVC.modalPresentationStyle = .pageSheet
        
        haptic.setupImpactHaptic(style: .light)
            
        self.window?.rootViewController?.present(safariVC, animated: true, completion: nil)
            
        } else {
            
        let alert = UIAlertController(title: NSLocalizedString("Movie Trailer Not Available", comment: ""),
                        message: NSLocalizedString("Please, try again later.", comment: ""),
                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Ok Button Pressed")
        })
            
        alert.addAction(okAction)
            
        haptic.setupNotificationHaptic(type: .error)
            
        self.window?.rootViewController?.present(alert, animated: true, completion:nil)
            
        }
        
        
    }
    
    @IBAction func seeTMDb(_ sender: Any) {
        
        haptic.setupImpactHaptic(style: .light)
        
        //print("MovieID: \(currentMovie)")
        
        var currentMovie = [Array(dao.movies)[dao.currentMovie]]
        
        let safariVC = SFSafariViewController(url: URL(string: "https://www.themoviedb.org/movie/\(currentMovie.first!.key)")!)
        safariVC.delegate = self
        safariVC.modalPresentationStyle = .pageSheet
        
        self.window?.rootViewController?.present(safariVC, animated: true, completion: nil)
        
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
