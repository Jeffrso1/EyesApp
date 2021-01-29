//
//  CastListTableViewCell2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class CastListTableViewCell2: UITableViewCell, DAORequester {
    
//    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    func updated() {
       
        DispatchQueue.main.async {
        
            self.castCollectionView.reloadData()
        
        }
        
    }
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    let castID = "castID"
    
    var movie : Movie?
    
    let castCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.backgroundColor()
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let sessionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell() {
        backgroundColor = UIColor.backgroundColor()
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(CastCVCell2.self, forCellWithReuseIdentifier: castID)
        castCollectionView.contentInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        
        if let layout = castCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        contentView.addSubview(castCollectionView)
        contentView.addSubview(sessionTitle)
        
        sharedConstraints.append(contentsOf: [
            
            castCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            castCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            sessionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sessionTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            sessionTitle.bottomAnchor.constraint(equalTo: castCollectionView.topAnchor)
            
        ])
        
        regularConstraints.append(contentsOf: [
            
            sessionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100)
            
        ])
        
        compactConstraints.append(contentsOf: [
            
            sessionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 29)
            
        ])
        
        NSLayoutConstraint.activate([
            
        ])
        
        sessionTitle.text = NSLocalizedString("Cast", comment: "")
        sessionTitle.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
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
            castCollectionView.contentInset = UIEdgeInsets(top: 20.0, left: 100.0, bottom: 20.0, right: 20.0)
            sessionTitle.font = UIFont.boldSystemFont(ofSize: 27)
        }
    }
    
}

extension CastListTableViewCell2: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movie?.cast?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castID, for: indexPath) as! CastCVCell2
 
        cell.setupCastCell(indexPath: indexPath, movie: self.movie!)
        
        return cell
    }
    
    
}

extension CastListTableViewCell2: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 100)
    }
}
