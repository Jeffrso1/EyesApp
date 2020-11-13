//
//  ChooseTagsCollectionViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 25/10/20.
//

import UIKit

class ChooseTagsCollectionViewCell: UICollectionViewCell {
    
    var cellTag : Tag?
    
    var buttonIsSelected : Bool {
        get {
            return cellTag?.isSelected ?? false
        }
        set {
            self.cellTag?.isSelected = newValue
        }
    }
    
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
            haptic.setupImpactHaptic(style: .light)
            tagButton.backgroundColor = UIColor(named: "AccentColor")
        case false:
            haptic.setupImpactHaptic(style: .heavy)
            tagButton.backgroundColor = UIColor(named: "Button")
        }
    }
    
    func setupTag(tag: Tag) {
        
        let langStr = Locale.current.languageCode
        
        if langStr == "pt" {
        tagButton.setTitle(tag.displayName_ptBR, for: .normal)
        } else {
        tagButton.setTitle(tag.displayName_enUS, for: .normal)
        }
        
        self.cellTag = tag

    }
    
    
}
