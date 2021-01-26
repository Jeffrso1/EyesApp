//
//  TagsTableViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class TagsTableViewCell2: UITableViewCell, DAORequester {
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    
    func updated() {
       
        DispatchQueue.main.async {
        
            self.tagsCollectionView.reloadData()
        
        }
        
    }
    
    let tagsID = "tagsID"
    var tags : [Tag] = []
    
    var collectionViewHeight : CGFloat = 0
    
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
            sessionTitle.font = UIFont.boldSystemFont(ofSize: 27)
        }
    }
    
    
    func setupCell(movie: Movie) {
        
        backgroundColor = UIColor.backgroundColor()
        
        tags = (dao.myMovies[Int(movie.id)]?.tags) ?? []
        
        tagsCollectionView.register(InsideTagsCollectionViewCell2.self, forCellWithReuseIdentifier: tagsID)
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.backgroundColor = UIColor.backgroundColor()
        tagsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 20.0, right: 20.0)
        
        if let layout = tagsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        contentView.addSubview(sessionTitle)
        contentView.addSubview(tagsCollectionView)
        
        let tagsHeightConstraint = tagsCollectionView.heightAnchor.constraint(equalToConstant: 208)
        tagsHeightConstraint.priority = UILayoutPriority(999)
        let tagsiPadHeight = tagsCollectionView.heightAnchor.constraint(equalToConstant: 100)
        
        
        sharedConstraints.append(contentsOf: [
            
            sessionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            tagsHeightConstraint,
            tagsCollectionView.topAnchor.constraint(equalTo: sessionTitle.bottomAnchor, constant: 20),
           
            tagsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
        regularConstraints.append(contentsOf: [
            
            sessionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            tagsCollectionView.leadingAnchor.constraint(equalTo: sessionTitle.leadingAnchor),
            tagsiPadHeight            
        ])
        
        compactConstraints.append(contentsOf: [
            
            sessionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 29),
            sessionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -29),
            tagsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
        ])
        
        sessionTitle.text = NSLocalizedString("Why Should You Watch It?", comment: "")
        sessionTitle.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        
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

extension TagsTableViewCell2: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 55)
    }
}
