//
//  OverviewTableViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class OverviewTableViewCell2: UITableViewCell {

    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []

    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
           // activating shared constraints
           NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            // activating compact constraints
            NSLayoutConstraint.activate(compactConstraints)
            
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    
    
    func setupCell(movie: Movie) {
        backgroundColor = UIColor.backgroundColor()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        
        let heightConst = overviewLabel.heightAnchor.constraint(equalToConstant: 20)
        heightConst.priority = UILayoutPriority(rawValue: 250)
        
        
        sharedConstraints.append(contentsOf: [
               
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 29),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            heightConst
            
        ])
        
        regularConstraints.append(contentsOf: [
 
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -400),
        
        ])
        
        compactConstraints.append(contentsOf: [

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 29),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -29),
            
        ])
        
        titleLabel.text = NSLocalizedString("Overview", comment: "")
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        overviewLabel.text = movie.overview
        overviewLabel.numberOfLines = 0
        overviewLabel.sizeToFit()
        
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        
    }
    
}
