//
//  NavigationBar.swift
//  Eyes
//
//  Created by Lucas Frazão on 01/12/20.
//

import Foundation
import UIKit

let navigationBar = NavigationBar()

class NavigationBar {
    
    func configNavBar(view: UIViewController) {
        
        view.navigationController?.navigationBar.isHidden = false
        view.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        view.navigationController?.navigationBar.shadowImage = UIImage()
        view.navigationController?.navigationBar.isTranslucent = true
        view.navigationController?.navigationBar.tintColor = .white
        view.navigationController?.view.backgroundColor = UIColor.clear
        view.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        view.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.navigationController?.navigationBar.layer.shadowRadius = 3
        view.navigationController?.navigationBar.layer.shadowOpacity = 0.3

    }
    
    
}

