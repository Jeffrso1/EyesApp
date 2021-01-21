//
//  HeaderCollectionViewCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 28/10/20.
//

import UIKit
import SafariServices

//Pass any objects, params you need to use on the
//segue call to send to the next controller.

protocol MovieReviewDelegate {
    func callSegueFromCell(dataObject: Movie)
}

class HeaderTableViewCell: UITableViewCell, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var movieHeader: UIImageView!
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var timeAndGenre: UILabel!
    @IBOutlet weak var watchTrailer: UIButton!
    @IBOutlet weak var seeTMDb: UIButton!
    
    var movie: Movie?
    
    var delegate: MovieReviewDelegate!
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    func setupHeaderCell(movie: Movie) {
 
        self.movie = movie
        
        timeAndGenre.text = movie.durationText + " • " + movie.genreText
        
        imageLoader.loadAsyncPosterImage(from: movie) { image in
            self.movieBanner.image = image
        }
        
        //movieBanner.layer.cornerRadius = 7
       // movieTitle.text = movie.title
        
        imageLoader.loadAsyncImage(from: movie) { image in
            self.movieHeader.image = image
        }
        
        let view = UIView(frame: movieHeader.bounds)

        let clearColor = UIColor.black.withAlphaComponent(0.2)
        
        let gradient = CAGradientLayer()

        gradient.frame.size.height = movieHeader.bounds.height
        
        gradient.frame.size.width = UIScreen.main.bounds.width

        gradient.colors = [clearColor.cgColor, UIColor.backgroundColor().cgColor]

        gradient.locations = [0.0, 1.0]

        view.layer.insertSublayer(gradient, at: 0)

        movieHeader.addSubview(view)
        movieHeader.bringSubviewToFront(view)
        
        setupButton(button: watchTrailer)
        setupButton(button: seeTMDb)
    
    }
    
    func setupButton(button: UIButton) {
        
        button.cornerRadius = 7
        
    }
    
    
    @IBAction func watchTrailer(_ sender: Any) {
        
        do {
            
        try checkMovieTrailer()
        
            
        } catch MovieDetailError.trailerNotAvailable {
        
            Alert.showBasic(title: NSLocalizedString("Movie Trailer Not Available", comment: ""), message: NSLocalizedString("Please, try again later.", comment: ""), vc: (self.window?.rootViewController)!, type: .error)
            
        } catch {
            Alert.showBasic(title: NSLocalizedString("There was a problem loading this movie.", comment: ""), message: NSLocalizedString("Please, try again later.", comment: ""), vc: (self.window?.rootViewController)!, type: .error)
        }
        
        
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
    
    @IBAction func reviewMovie(_ sender: Any) {
        
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.callSegueFromCell(dataObject: movie!)
        }
        
        haptic.setupImpactHaptic(style: .light)
        
    }
    
 
}
