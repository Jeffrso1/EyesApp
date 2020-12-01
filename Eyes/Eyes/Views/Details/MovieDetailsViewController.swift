//
//  MovieDetailsViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 21/10/20.
//

import UIKit
import MessageUI

class MovieDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, DAORequester, MFMailComposeViewControllerDelegate {
    
    var movie: Movie?
    var imageID: UIImage?
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageLoader = ImageLoader()
    
    var lastOffsetY :CGFloat = 0

    var alpha : CGFloat = 0.0
    
    @IBOutlet weak var optionsButton: UIBarButtonItem!
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    @IBAction func optionsButton(_ sender: Any) {
        
        if dao.selectedMovie == nil {
            dao.selectedMovie = currentMovie
        }
        
        let shareViewController = ShareImage(movie: dao.selectedMovie!)
        
        let renderer = UIGraphicsImageRenderer(size: shareViewController.view.bounds.size)
        let image = renderer.image { ctx in
            shareViewController.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        Alert.showMovieOptions(vc: self, image: image, movie: dao.selectedMovie!)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            // Dismiss the mail compose view controller.
        
        controller.dismiss(animated: true, completion: nil)
        
        switch result.rawValue {
            case MFMailComposeResult.cancelled.rawValue :
                print("Cancelled")

            case MFMailComposeResult.failed.rawValue :
                print("Failed")
                
                Alert.showBasic(title: NSLocalizedString("There was a problem sending your feedback", comment: ""), message:NSLocalizedString("Please, try again later.", comment: "") , vc: self, type: .error)

            case MFMailComposeResult.saved.rawValue :
                print("Saved")

            case MFMailComposeResult.sent.rawValue :
                print("Sent")

                Alert.showBasic(title: NSLocalizedString("Thanks for your feedback!", comment: ""), message:NSLocalizedString("Your opinion is very important to us. We'll be in touch soon.", comment: "") , vc: self, type: .success)

            default: break


            }
            
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension

        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func updateHeight() {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! HeaderTableViewCell
            
            cell.setupHeaderCell()
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overview", for: indexPath) as! OverviewTableViewCell
            
            cell.setupOverviewCell()
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tags", for: indexPath) as! TagsTableViewCell
            
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cast", for: indexPath) as! CastListTableViewCell
            
            cell.collectionView.reloadData()
            updateHeight()
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "")!
            
            return cell
        }

        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
                
        let transition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.fade
        
        lastOffsetY = scrollView.contentOffset.y
        
        if lastOffsetY > 60 {
        
            UIView.animate(withDuration: 0.5, animations: {
               
                self.navigationController?.navigationBar.alpha = 1.0
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
                self.navigationController?.navigationBar.shadowImage = nil
                self.navigationController?.navigationBar.isTranslucent = true
                self.navigationController?.view.backgroundColor = UIColor.black
                
            }, completion: nil)
            
        } else {
          
            
            UIView.animate(withDuration: 0.5, animations: {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
           // self.navigationController?.navigationBar.alpha = 0.8
                
            }, completion: nil)
        }
        
        
    }

    
    func updated() {
        
        //        movieImage.image = imageID
        
    }
    
}
