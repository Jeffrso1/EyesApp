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
    
    class func showMovieOptions(vc: UIViewController, image: UIImage){
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        let actionSheet = UIAlertController(title: NSLocalizedString("Movie Options", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Share on Instagram Stories", comment: ""), style: .default, handler: { _ in vc.present(activityController, animated: true)}))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Report Issue", comment: ""), style: .destructive, handler: nil))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        vc.present(actionSheet, animated: true)
        
        haptic.setupImpactHaptic(style: .light)
        
    }
    
    
    
}

