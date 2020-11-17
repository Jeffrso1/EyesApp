//
//  OBViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 04/11/20.
//

import UIKit

class OBViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueSegue(_ sender: Any) {
        //UserDefaults.standard.set(true, forKey: "firstLaunch")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        self.navigationController?.navigationBar.isHidden = true
        
    }

    func setupButton() {
        self.continueButton.layer.cornerRadius = 7
        self.continueButton.layer.shadowRadius = 10
    }
}
