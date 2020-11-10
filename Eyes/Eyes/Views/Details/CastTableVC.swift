//
//  CastTableViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 03/11/20.
//

import UIKit

class CastTableVC: UITableViewCell {

    
    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var characterName: UILabel!
    //@IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
