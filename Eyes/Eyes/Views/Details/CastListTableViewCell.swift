//
//  CastCollectionViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 03/11/20.
//

import UIKit

class CastListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    let cellIdentifier: String = "castCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if dao.selectedMovie == nil {
            dao.selectedMovie = currentMovie
        }
        
        switch dao.selectedMovie?.cast?.count {
        case 0:
            return 1
        default:
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath as IndexPath) as! CastCVCell
      
        cell.setupCastCell(indexPath: indexPath)
        
        return cell
    }
    
    
    
    
}

