//
//  ShimmerView.swift
//  Eyes
//
//  Created by Lucas Frazão on 12/02/21.
//

import UIKit

let shimmer = ShimmerView()

class ShimmerView: UIView {
    
    var gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    var gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
    
    func startAnimating() {
        let gradientLayer = CAGradientLayer()
        /* Allocate the frame of the gradient layer as the view's bounds, since the layer will sit on top of the view. */
        
        gradientLayer.frame = self.bounds
        /* To make the gradient appear moving from left to right, we are providing it the appropriate start and end points.
         Refer to the diagram above to understand why we chose the following points.
         */
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo,   gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        /* Adding the gradient layer on to the view */
        self.layer.addSublayer(gradientLayer)
    }
    
    
    
    
}
