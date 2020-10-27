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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isHidden = true
        
    }
    

}
