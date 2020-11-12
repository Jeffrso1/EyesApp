//
//  CarouselTagCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 10/11/20.
//

import UIKit

class CarouselTagCell: UICollectionViewCell {
    
    var tagsName: UIButton = {
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        
        return uiButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tagsName)
        
        tagsName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tagsName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tagsName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        tagsName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        tagsName.backgroundColor = UIColor(named: "AccentColor")
        tagsName.setTitleColor(.white, for: .normal)
        tagsName.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        tagsName.sizeToFit()
         
        tagsName.contentEdgeInsets = UIEdgeInsets(top: 14.0, left: 20.0, bottom: 14.0, right: 20.0)
        
        tagsName.layer.cornerRadius = 7
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupTagCell(title: String) {
        tagsName.setTitle(title, for: .normal)
        tagsName.titleLabel?.numberOfLines = 2
        tagsName.titleLabel?.adjustsFontSizeToFitWidth = true
        tagsName.titleLabel?.lineBreakMode = .byClipping
        tagsName.titleLabel?.textAlignment = .center
    }
}
