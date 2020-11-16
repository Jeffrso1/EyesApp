//
//  InsideTagsCollectionViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 06/11/20.
//

import UIKit

class InsideTagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
        
    }
        
    fileprivate func setupButton() {
        
        tagButton.titleLabel?.numberOfLines = 2
        tagButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tagButton.titleLabel?.lineBreakMode = .byClipping
        tagButton.titleLabel?.textAlignment = .center
        
       tagButton.contentEdgeInsets = UIEdgeInsets(top: 15.0, left: 30.0, bottom: 15.0, right: 30.0)
        
       tagButton.layer.cornerRadius = 7
  
    }
    
    
}
