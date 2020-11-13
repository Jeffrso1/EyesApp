//
//  CastCollectionViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 03/11/20.
//

import UIKit

class CastListTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    //@IBOutlet weak var castName: UILabel!
    //@IBOutlet weak var characterName: UILabel!
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier: String = "castCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovie?.cast?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath as IndexPath) as! CastTableVC
        
        //print("Table View Loaded")
        
        cell.castName.text = currentMovie?.cast?[indexPath.row].name ?? "Cast Name Not Available"
        cell.characterName.text = currentMovie?.cast?[indexPath.row].character ?? "Character Name Not Available"
        
        return cell
        
    }
    

    func setupOverviewCell() {
        
        
       
    }
    
    
}

