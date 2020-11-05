//
//  CatalogueViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 22/10/20.
//

import UIKit

class CatalogueViewController: UIViewController, UIPageViewControllerDelegate {
   
    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    @IBAction func showDetails(_ sender: UIButton) {
   
    
    }
    
    var currentPage : Int = 0
//    let pageViewController = PageViewController()
    var selectedID : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configNavBar()
    }
    
    func configNavBar() {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.3

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "movieReview" {
            let vc = segue.destination as! BechdelTestViewController
            selectedID = Array(dao.movies)[dao.currentMovie].key
            vc.movieID = selectedID
                
            print("Review Movie pressed")
                
        }
        
        if segue.identifier == "movieDetails" {
            let vc = segue.destination as! MovieDetailsViewController
            selectedID = Array(dao.movies)[dao.currentMovie].key
            vc.movieID = selectedID
                
            print("Details Button pressed")
        }
        
        if segue.identifier == "about" {
            let vc = segue.destination as! AboutAppViewController
            vc.navigationController?.navigationBar.prefersLargeTitles = true
                
            print("About Section pressed")
        }
        
        
    }
    
    
    @IBAction func backToCatalogue( _ segue: UIStoryboardSegue) {
        
        
    }
    
}
