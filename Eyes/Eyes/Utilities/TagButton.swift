//
//  TagButton.swift
//  Eyes
//
//  Created by Lucas Frazão on 25/10/20.
//

import UIKit

class TagButton: UIButton {
    
    var i = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //setupButton()
    }
    
    
    func setupButton() {
        styleButton()
        setupConstraints()
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func styleButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(named: "Button")
        layer.cornerRadius = 10
    }
    
}
