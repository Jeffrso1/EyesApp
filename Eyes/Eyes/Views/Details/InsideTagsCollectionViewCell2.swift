//
//  InsideTagsCollectionViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 21/01/21.
//

import UIKit

class InsideTagsCollectionViewCell2: UICollectionViewCell {
    let tagButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
        
    }
    
    func setupButton() {
        contentView.addSubview(tagButton)
        
        NSLayoutConstraint.activate([
            tagButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagButton.widthAnchor.constraint(equalToConstant: 238),
            tagButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        tagButton.titleLabel?.numberOfLines = 2
        tagButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tagButton.titleLabel?.lineBreakMode = .byClipping
        tagButton.titleLabel?.textAlignment = .center
        
       tagButton.contentEdgeInsets = UIEdgeInsets(top: 15.0, left: 30.0, bottom: 15.0, right: 30.0)
        
       tagButton.layer.cornerRadius = 7
    }
}
