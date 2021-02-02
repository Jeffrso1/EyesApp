//
//  CastCVCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 27/01/21.
//

import UIKit

class CastCVCell2: UICollectionViewCell {
    
    let castName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(ftView)
        contentView.addSubview(castName)
        contentView.addSubview(characterName)
        
        NSLayoutConstraint.activate([
            castName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            castName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            castName.heightAnchor.constraint(equalToConstant: 42),
            castName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -12.5),
            
            characterName.leadingAnchor.constraint(equalTo: castName.leadingAnchor),
            characterName.trailingAnchor.constraint(equalTo: castName.trailingAnchor),
            characterName.topAnchor.constraint(equalTo: castName.bottomAnchor),
            
            ftView.leadingAnchor.constraint(equalTo: castName.leadingAnchor, constant: -15),
            ftView.trailingAnchor.constraint(equalTo: castName.trailingAnchor, constant: 15),
            ftView.topAnchor.constraint(equalTo: castName.topAnchor, constant: -15),
            ftView.bottomAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 20)
        ])
        
        ftView.backgroundColor = UIColor(displayP3Red: 42/255, green: 42/255, blue: 42/255, alpha: 1)
        ftView.layer.cornerRadius = 7
        
        castName.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        castName.text = "Cast Name"
        castName.numberOfLines = 2
        characterName.font = UIFont.systemFont(ofSize: 14)
        characterName.text = "Character Name"
        characterName.numberOfLines = 2
        
    }
    
    func setupCastCell(indexPath: IndexPath, movie: Movie) {
        
        if movie.cast?.count != 0 {
        
        castName.text = movie.cast?[indexPath.row].name ?? "Cast Name Not Available"
        characterName.text = movie.cast?[indexPath.row].character ?? "Character Name Not Available"
            
        }
        
    }
}
