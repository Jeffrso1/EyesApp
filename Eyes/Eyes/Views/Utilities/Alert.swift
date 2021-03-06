//
//  Alert.swift
//  Eyes
//
//  Created by Lucas Frazão on 14/11/20.
//

import Foundation
import UIKit
import MessageUI
import SafariServices

class Alert: UIViewController, MFMailComposeViewControllerDelegate {
    
    class func showBasic(title: String, message: String, vc: UIViewController, type: UINotificationFeedbackGenerator.FeedbackType) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
        
        haptic.setupNotificationHaptic(type: type)
        
    }
    
    class func showMovieOptions(vc: UIViewController, image: Data?, url: URL?, movie: Movie){
        
        let activityControllerImage = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        let activityControllerTrailer = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        let actionSheet = UIAlertController(title: NSLocalizedString("Movie Options", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Save or Share Image", comment: ""), style: .default, handler: { _ in vc.present(activityControllerImage, animated: true)}))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Share Trailer", comment: ""), style: .default, handler: { _ in vc.present(activityControllerTrailer, animated: true)}))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("See in on TMDb", comment: ""), style: .default, handler: { action in
            
        seeTMDB(from: vc)
            
        }))
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Report Issue", comment: ""), style: .destructive, handler: { action in
            
        sendEmail(movie: movie)
 
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        if let popoverActivityController = activityControllerImage.popoverPresentationController {
            popoverActivityController.sourceView = vc.view
            popoverActivityController.sourceRect = CGRect(x: UIScreen.main.bounds.width - 40, y: 40, width: 1.0, height: 1.0)
        }
        
        if let popoverActivityController = activityControllerTrailer.popoverPresentationController {
            popoverActivityController.sourceView = vc.view
            popoverActivityController.sourceRect = CGRect(x: UIScreen.main.bounds.width - 40, y: 40, width: 1.0, height: 1.0)
        }
        
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = vc.view
            popoverPresentationController.sourceRect = CGRect(x: UIScreen.main.bounds.width - 40, y: 40, width: 1.0, height: 1.0)
        }
        
        
        vc.present(actionSheet, animated: true)
        
        haptic.setupImpactHaptic(style: .light)
        
        
        func sendEmail(movie: Movie) {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = vc as? MFMailComposeViewControllerDelegate
                mail.setToRecipients(["contact.eyesapp@gmail.com"])
                mail.setSubject("\(NSLocalizedString("Report Issue:", comment: "")) \(movie.title)")
                mail.setMessageBody("<p><h3>\(NSLocalizedString("Please, describe the issue regarding", comment: "")) \(movie.title).</h3></p>\(NSLocalizedString("If it is related to one or more tags, please list them all and why they are not correct", comment: ""))</p>", isHTML: true)
                
                vc.view.backgroundColor = UIColor(named: "AccentColor")
                vc.present(mail, animated: true)
            } else {
                // show failure alert
                print("error sending e-mail")
                self.showBasic(title: NSLocalizedString("Your request could not be completed", comment: "Request Not Completed"), message: NSLocalizedString("Make sure you have an e-mail account set up on your iPhone", comment: "Account Not Set Up"), vc: vc, type: .error)
            }
        }
        
        
        func seeTMDB(from: UIViewController) {
            
            let arrayCurrentMovie = dao.selectedMovie
            
            let safariVC = SFSafariViewController(url: URL(string: "https://www.themoviedb.org/movie/\(arrayCurrentMovie!.id)")!)
            safariVC.delegate = vc as? SFSafariViewControllerDelegate
            safariVC.modalPresentationStyle = .pageSheet
            
            vc.present(safariVC, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
}

