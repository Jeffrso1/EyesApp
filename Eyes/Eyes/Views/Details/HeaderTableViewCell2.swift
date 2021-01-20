//
//  HeaderTableViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class HeaderTableViewCell2: UITableViewCell {

    let movieHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell() {
        addSubview(movieHeader)
        
        NSLayoutConstraint.activate([
            movieHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieHeader.heightAnchor.constraint(equalToConstant: 281),
            movieHeader.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            movieHeader.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            movieHeader.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
        
        movieHeader.image = UIImage(named: "movie")
    }
    
}
