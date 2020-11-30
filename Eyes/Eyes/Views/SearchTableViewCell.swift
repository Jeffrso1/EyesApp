//
//  SearchTableViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 30/11/20.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    
    func setupMovieResults(indexPath: IndexPath) {
        
        
        
    }

}
