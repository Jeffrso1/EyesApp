//
//  CaroulselViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 22/10/20.
//
import UIKit

@IBDesignable
class CarouselItem: UIView {
    static let CAROUSEL_ITEM_NIB = "CarouselItem"
    
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var movieBlurBanner: UIImageView!
    @IBOutlet var vwContent: UIView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var timeAndGenre: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(movie: Movie) {
        self.init()
        movieName.text = movie.title
        movieDescription.text = movie.overview
        timeAndGenre.text = movie.durationText + " • " + movie.genreText
       
        movieBanner.image = UIImage(named: "wait")!
        movieBlurBanner.image = UIImage(named: "wait")!
        
        loadAsyncImage(from: movie) { image in
            self.movieBanner.image = image
            self.movieBlurBanner.image = image
        }

        movieBanner.layer.cornerRadius = 10
        movieBanner.clipsToBounds = false
        movieBanner.layer.masksToBounds = true
        
        //Config Blur View Background
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: movieBlurBanner.bounds.width + 30, height: movieBlurBanner.bounds.height + 30)
        movieBlurBanner.contentMode = .scaleAspectFill
        movieBlurBanner.addSubview(blurView)
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.CAROUSEL_ITEM_NIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
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
