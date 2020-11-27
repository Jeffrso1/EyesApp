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

/*
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovie?.cast?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath as IndexPath) as CastCVCell

        //print("Table View Loaded")



        return cell
        
    }
    
 */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch currentMovie?.cast?.count {
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

