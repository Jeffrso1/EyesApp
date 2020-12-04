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
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieImage.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
       
        
    }
    
    
    func setupMovieResults(indexPath: IndexPath) {
        
        
        
    }

}
