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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(titleText: String? = "", movieDesc: String? = "", image: UIImage?) {
        self.init()
        movieName.text = titleText
        movieDescription.text = movieDesc
        movieBanner.image = image
        movieBlurBanner.image = image
        movieBlurBanner.contentMode = .scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = movieBlurBanner.bounds
        movieBlurBanner.addSubview(blurView)
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.CAROUSEL_ITEM_NIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
    }
    
}
