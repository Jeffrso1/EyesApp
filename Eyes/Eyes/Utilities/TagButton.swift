//
//  TagButton.swift
//  Eyes
//
//  Created by Lucas Frazão on 25/10/20.
//

import UIKit

//@IBDesignable
class TagButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupButton()
    }
    
    
    func setupButton() {
        styleButton()
        setupConstraints()
    }
    
    func setupConstraints() {
        //addSubview()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        //centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    func styleButton() {
        setTitleColor(.white, for: .normal)
        
        backgroundColor = UIColor(named: "AccentColor")
        layer.cornerRadius = 10
    }
    
    
}
