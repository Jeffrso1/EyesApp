//
//  ConfirmationButton.swift
//  Eyes
//
//  Created by Lucas Frazão on 22/10/20.
//

import Foundation
import UIKit

public class ConfirmationButton: UIButton {
    
    public override var isHighlighted :Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                self.backgroundColor = UIColor.darkGray 
            }
            else {
                self.backgroundColor = UIColor(named: "AccentColor")
            }
            super.isHighlighted = newValue
        }
    }

    
    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

     
        //self.layer.borderWidth = 1
        //self.backgroundColor = UIColor.whiteColor()
        //self.layer.borderColor = UIColor.blackColor().CGColor

    }
    
    
    
}
