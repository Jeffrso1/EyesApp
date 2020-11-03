//
//  CastCollectionViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 03/11/20.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var characterName: UILabel!
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]

    @IBOutlet weak var tableView: UITableView!
    // var tableView = UITableView()
    let cellIdentifier: String = "castCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovie?.cast?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath as IndexPath) as! CastTableViewCell
        
        cell.castName.text = currentMovie?.cast?[indexPath.row].name ?? "Cast Name Not Available"
        cell.characterName.text = currentMovie?.cast?[indexPath.row].character ?? "Character Name Not Available"
        
        return cell
    }
    

    func setupOverviewCell() {
        
       
    }
    
    
}

