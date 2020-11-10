//
//  OBItem.swift
//  Eyes
//
//  Created by Jefferson Silva on 04/11/20.
//

import UIKit

class OBItem: UIView {
    
    static let OB_ITEM_NIB = "OBItem"
    
    @IBOutlet var vwContent: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageSubtitle: UILabel!
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(title: String, subtitle: String, image: UIImage) {
        self.init()
        pageTitle.text = title
        pageSubtitle.text = subtitle
        pageImage.image = image
        
       //pageImage.layer.cornerRadius = 10
        pageImage.clipsToBounds = false
        pageImage.layer.shadowColor = UIColor.black.cgColor
        pageImage.layer.shadowOffset = CGSize(width: 0, height: 0)
        pageImage.layer.shadowRadius = 20
        pageImage.layer.shadowOpacity = 0.5
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(OBItem.OB_ITEM_NIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
    }
}
