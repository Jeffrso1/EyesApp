//
//  OverviewCollectionViewCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 28/10/20.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overviewText: UILabel!
    
    func setupOverviewCell() {
        overviewText.text = dao.movies[Array(dao.movies)[dao.currentMovie].key]?.overview
    }
}
