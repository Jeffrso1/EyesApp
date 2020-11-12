//
//  AboutDevTeamCollectionViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 11/11/20.
//

import UIKit

class AboutDevTeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var devTeamImage: UIImageView!
    @IBOutlet weak var devName: UILabel!
    @IBOutlet weak var devSocialMedia: UIButton!
    @IBOutlet weak var bgView: UIView!
    
 
    
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupDevTeam(devTeam: DevTeam) {
        
        bgView.layer.cornerRadius = 7
        devTeamImage.image = UIImage(named: devTeam.imageName)
        devName.text = devTeam.devName
        devSocialMedia.setTitle(devTeam.socialMediaName, for: .normal)
        
    }
    
    
}


class DevTeam {
    
    var imageName: String
    var devName: String
    var socialMediaName: String
    var socialMediaURL: String
    
    init(imageName: String, devName: String, socialMediaName: String, socialMediaURL: String) {
        self.imageName = imageName
        self.devName = devName
        self.socialMediaName = socialMediaName
        self.socialMediaURL = socialMediaURL
    }
    

}
