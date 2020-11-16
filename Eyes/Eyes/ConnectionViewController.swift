//
//  ConnectionViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 16/11/20.
//

import UIKit

class ConnectionViewController: UIViewController {

    var testMessage: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemRed
        view.addSubview(testMessage)
    }

    func setupTestMessage() {
        testMessage.text = "Deu merda na internet."
        testMessage.textColor = .white
        
        testMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        testMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        testMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        testMessage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
