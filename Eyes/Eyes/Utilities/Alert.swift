//
//  Alert.swift
//  Eyes
//
//  Created by Lucas Frazão on 14/11/20.
//

import Foundation
import UIKit

class Alert {
    
    class func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
        
        haptic.setupNotificationHaptic(type: .error)
        
    }
    
    
}

