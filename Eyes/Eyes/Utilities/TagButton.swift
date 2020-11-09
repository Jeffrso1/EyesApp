//
//  TagButton.swift
//  Eyes
//
//  Created by Lucas Frazão on 25/10/20.
//

import UIKit

//@IBDesignable
class TagButton: UIButton {
    
    var i = 0
    
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
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        //centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    func styleButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(named: "Button")
        layer.cornerRadius = 10
    }
    
    @objc func tapped() {
            i += 1
            print("Running \(i)")

            switch i {
            case 1:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)

            case 2:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)

            case 3:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)

            case 4:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()

            case 5:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()

            case 6:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()

            default:
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
                i = 0
            }
        }
    
    
}
