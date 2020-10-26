//
//  ChooseTagsCollectionViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 25/10/20.
//

import UIKit

class ChooseTagsCollectionViewCell: UICollectionViewCell {
    
    var buttonIsSelected : Bool = false
    
    @IBOutlet weak var tagButton: UIButton!
    
    override func awakeFromNib() {
           
        setupButton()
        
    }
    
    fileprivate func setupButton() {
  
       tagButton.sizeToFit()
        
       tagButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 30.0, bottom: 10.0, right: 30.0)
        
       tagButton.layer.cornerRadius = 7
  
    }
    
    @IBAction func tagSelected(_ sender: UIButton) {
        
        self.buttonIsSelected.toggle()
        checkButtonStatus()
    }
    
    fileprivate func checkButtonStatus() {
        
        switch buttonIsSelected {
            case true:
            tagButton.backgroundColor = UIColor(named: "AccentColor")
            case false:
            tagButton.backgroundColor = UIColor(named: "Button")
        
        }
        
    }
    
}
