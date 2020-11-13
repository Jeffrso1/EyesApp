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
        
       tagButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 30.0, bottom: 10.0, right: 30.0)
        
       tagButton.layer.cornerRadius = 7
  
    }
    
    
}
