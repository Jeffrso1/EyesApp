//
//  InsideTagsCollectionViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 21/01/21.
//

import UIKit

class InsideTagsCollectionViewCell2: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
   
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
        
        self.translatesAutoresizingMaskIntoConstraints = false
        setupButton()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tagButton)
        
        tagButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tagButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tagButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tagButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        tagButton.backgroundColor = UIColor(named: "AccentColor")
        tagButton.setTitleColor(.white, for: .normal)
        tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        tagButton.sizeToFit()
        
        tagButton.titleLabel?.numberOfLines = 2
        tagButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tagButton.titleLabel?.lineBreakMode = .byClipping
        tagButton.titleLabel?.textAlignment = .center
         
        tagButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        tagButton.layer.cornerRadius = 7
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupButton() {
        
        //contentView.addSubview(tagButton)
        
        
        
    }
    
    
}
