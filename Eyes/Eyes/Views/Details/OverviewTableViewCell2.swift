//
//  OverviewTableViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class OverviewTableViewCell2: UITableViewCell {

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
    
    func setupCell(movie: Movie) {
        backgroundColor = UIColor.backgroundColor()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        
        let heightConst = overviewLabel.heightAnchor.constraint(equalToConstant: 20)
        heightConst.priority = UILayoutPriority(rawValue: 250)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 29),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -29),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 29),
            
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            heightConst
        ])
        
        titleLabel.text = "Mais Informações"
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        overviewLabel.text = movie.overview
        overviewLabel.numberOfLines = 0
        overviewLabel.sizeToFit()
        
    }
    
}
