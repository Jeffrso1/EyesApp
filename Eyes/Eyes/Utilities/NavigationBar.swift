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
    
    func blurredNavBar(view: UIViewController) {
    
        view.navigationController?.navigationBar.alpha = 1.0
        view.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        view.navigationController?.navigationBar.shadowImage = nil
        view.navigationController?.navigationBar.isTranslucent = true
        view.navigationController?.view.backgroundColor = UIColor.black
        
        
    }
    
    
    
    
}

//Pop View Controller

extension UINavigationController {

  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
      popToViewController(vc, animated: animated)
    }
  }

  func popViewControllers(viewsToPop: Int, animated: Bool = true) {
    if viewControllers.count > viewsToPop {
      let vc = viewControllers[viewControllers.count - viewsToPop - 1]
      popToViewController(vc, animated: animated)
    }
  }

}

