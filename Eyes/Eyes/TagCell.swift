//
//  TagCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 06/11/20.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var tagsName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
            
    
    }
    
    func setupTagCell() {
        
        tagsName.sizeToFit()
         
        tagsName.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 30.0, bottom: 10.0, right: 30.0)
         
        tagsName.layer.cornerRadius = 7
        
    }
}
