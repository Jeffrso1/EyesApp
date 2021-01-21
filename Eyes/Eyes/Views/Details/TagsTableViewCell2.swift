//
//  TagsTableViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class TagsTableViewCell2: UITableViewCell, DAORequester {
    func updated() {
        DispatchQueue.main.async {
        
            self.tagsCollectionView.reloadData()
        
        }
    }
    

    let tagsID = "tagsID"
    var tags : [Tag] = []
    
    let tagsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let sessionTitle: UILabel = {
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
        tags = (dao.myMovies[Int(movie.id)]?.tags) ?? []
        
        tagsCollectionView.register(InsideTagsCollectionViewCell2.self, forCellWithReuseIdentifier: tagsID)
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.backgroundColor = UIColor.backgroundColor()
        
        contentView.addSubview(sessionTitle)
        contentView.addSubview(tagsCollectionView)
        
        let tagsHeightConstraint = tagsCollectionView.heightAnchor.constraint(equalToConstant: 208)
        tagsHeightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            sessionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 29),
            sessionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 29),
            sessionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -29),
            sessionTitle.bottomAnchor.constraint(equalTo: tagsCollectionView.topAnchor, constant: -20),
            
            tagsHeightConstraint,
            tagsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ])
        
        sessionTitle.text = "Why should I watch it?"
        sessionTitle.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
    }
    
}

extension TagsTableViewCell2: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tags.count != 0 {
            return tags.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagsID, for: indexPath) as! InsideTagsCollectionViewCell2
 
        let langStr = Locale.current.languageCode
        
        if tags.count != 0 {
            
            if langStr == "pt" {
                cell.tagButton.setTitle(tags[indexPath.row].displayName_ptBR, for: .normal)
            } else {
                cell.tagButton.setTitle(tags[indexPath.row].displayName_enUS, for: .normal)
            }
            
        } else {
            
            if langStr == "pt" {
                cell.tagButton.setTitle("Seja a primeira a analisar esse filme!", for: .normal)
            } else {
                cell.tagButton.setTitle("Be the first to review this movie!", for: .normal)
            }
        }

        return cell
    }
    
    
}
