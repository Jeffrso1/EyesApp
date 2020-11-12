//
//  AboutDevTeamVC.swift
//  Eyes
//
//  Created by Lucas Frazão on 11/11/20.
//

import UIKit
import SafariServices

class AboutDevTeamVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SFSafariViewControllerDelegate {
   
    var url = ""
    
    var devTeam : [DevTeam] = [DevTeam(imageName: "carol", devName: "Carol Marceli", socialMediaName: "Instagram", socialMediaURL: "https://www.instagram.com/carolmarceli/?hl=pt-br"), DevTeam(imageName: "jeff", devName: "Jefferson Silva", socialMediaName: "Instagram", socialMediaURL: "https://www.instagram.com"), DevTeam(imageName: "larissa", devName: "Larissa Diniz", socialMediaName: "Instagram", socialMediaURL: "https://www.instagram.com/lariediniz/"), DevTeam(imageName: "lucas", devName: "Lucas Frazão", socialMediaName: "Twitter", socialMediaURL: "https://www.twitter.com/lucasfrazao")]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devTeam.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "devTeam", for: indexPath) as! AboutDevTeamCollectionViewCell
        
        cell.setupDevTeam(devTeam: devTeam[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else {
            print("Something went wrong when selected a row!")
            return
        }
        
        if selectedIndexPath.item == 0 { // Name Row
            //identifier = "toOnboarding"
            //performSegue(withIdentifier: identifier, sender: self)
            url = devTeam[0].socialMediaURL
        } else if selectedIndexPath.item == 1 { // School Row
            //dataToSend = "school"
            url = devTeam[1].socialMediaURL
        } else if selectedIndexPath.item == 2 { // Grade Row
           //dataToSend = "grade"
            url = devTeam[2].socialMediaURL
        } else {
            url = devTeam[3].socialMediaURL
        }
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        
        var safariVC = SFSafariViewController(url: URL(string: url)!)
        safariVC.delegate = self
        safariVC.modalPresentationStyle = .pageSheet
        
        present(safariVC, animated: true, completion: nil)
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
