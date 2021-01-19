//
//  CatalogueViewController2.swift
//  Eyes
//
//  Created by Jefferson Silva on 18/01/21.
//

import UIKit

class CatalogueViewController2: UIViewController {
    
    let myPageVC = CarouselPageVC(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    let viewBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundColor()
        return view
    }()
    
    let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Avaliar Filme", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mais Detalhes", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.backgroundColor()
        
        view.addSubview(viewBox)
        view.addSubview(reviewButton)
        view.addSubview(detailsButton)
        
        setupViewBox()
        setupReviewButton()
        setupDetailsButton()
    }

    func setupViewBox() {
        NSLayoutConstraint.activate([
            viewBox.topAnchor.constraint(equalTo: view.topAnchor),
            viewBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewBox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        viewBox.addSubview(myPageVC.view)
        myPageVC.view.frame = viewBox.bounds
    }
    
    func setupReviewButton() {
        reviewButton.backgroundColor = UIColor.accentColor()
        reviewButton.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            reviewButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            reviewButton.heightAnchor.constraint(equalToConstant: 50),
            NSLayoutConstraint(item: reviewButton, attribute: .top, relatedBy: .equal, toItem: viewBox, attribute: .bottom, multiplier: 1, constant: 12)
        ])
    }
    
    func setupDetailsButton() {
        detailsButton.backgroundColor = UIColor.secondaryButton()
        detailsButton.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            detailsButton.leadingAnchor.constraint(equalTo: reviewButton.leadingAnchor),
            detailsButton.trailingAnchor.constraint(equalTo: reviewButton.trailingAnchor),
            detailsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            detailsButton.heightAnchor.constraint(equalTo: reviewButton.heightAnchor),
            NSLayoutConstraint(item: detailsButton, attribute: .top, relatedBy: .equal, toItem: reviewButton, attribute: .bottom, multiplier: 1, constant: 10)
        ])
    }
}
