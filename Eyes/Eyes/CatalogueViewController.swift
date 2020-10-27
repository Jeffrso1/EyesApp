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
                
            print("button pressed")
                
        }
    }
}
