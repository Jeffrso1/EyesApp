//
//  CatalogueViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 22/10/20.
//

import UIKit

class CatalogueViewController: UIViewController {
    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
      
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        
    }
    

}
