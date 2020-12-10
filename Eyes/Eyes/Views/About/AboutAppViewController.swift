//
//  AboutAppViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 29/10/20.
//

import UIKit
import SafariServices

class AboutAppViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
 
    var sections : [String] = [NSLocalizedString("HowToUseIt", comment: "How can you use the app?"), NSLocalizedString("Third-Party_APIs", comment: "APIs used on the app"), NSLocalizedString("Follow us on Social Media", comment: "Social Media Links"), NSLocalizedString("Development Team", comment: "")]
    
    var apis: [String] = ["TMDb API"]
    
    var howToUse: [String] = [NSLocalizedString("Watch On-boarding", comment: "Watch Tutorial")]
    
    var socialMedia: [String] = ["Facebook", "Instagram"]
    
    var devTeam: [String] = [NSLocalizedString("Get to know us!", comment: "")]

    
    var identifier = ""
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            print("Something went wrong when selected a row!")
            return
        }

        if selectedIndexPath.section == 0 { // Account Section

            if selectedIndexPath.row == 0 { // Name Row
                identifier = "toOnboarding"
                performSegue(withIdentifier: identifier, sender: self)
            } else if selectedIndexPath.row == 1 { // School Row
                //dataToSend = "school"
            } else if selectedIndexPath.row == 2 { // Grade Row
               //dataToSend = "grade"
            }

        } else if selectedIndexPath.section == 1 { // Private Section

            if selectedIndexPath.row == 0 { // Email Row
                identifier = "toDetails"
                performSegue(withIdentifier: identifier, sender: self)
            } else if selectedIndexPath.row == 1 { // Password Row
               //dataToSend = "password"
            } else if selectedIndexPath.row == 2 { // Phone Number Row
               // dataToSend = "phone"
            }

        } else if selectedIndexPath.section == 2 {
          
            if selectedIndexPath.row == 0 { // Email Row
                url = "https://web.facebook.com/AplicativoEyes"
            } else if selectedIndexPath.row == 1 { // Password Row
               //dataToSend = "password"
                url = "https://www.instagram.com/app.eyes/?hl=pt-br"
            } else if selectedIndexPath.row == 2 { // Phone Number Row
               // dataToSend = "phone"
            }

            var safariVC = SFSafariViewController(url: URL(string: url)!)
            safariVC.delegate = self
            
            present(safariVC, animated: true, completion: nil)
  
        } else if selectedIndexPath.section == 3 {
            
            if selectedIndexPath.row == 0 { // Email Row
                identifier = "toDevTeam"
                performSegue(withIdentifier: identifier, sender: self)
            } else if selectedIndexPath.row == 1 { // Password Row
               //dataToSend = "password"
                    
            } else if selectedIndexPath.row == 2 { // Phone Number Row
               // dataToSend = "phone"
            }
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return howToUse.count
        case 1:
            return apis.count
        case 2:
            return socialMedia.count
        default:
            return devTeam.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as! AboutTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.settingsLabel.text = howToUse[indexPath.row]
        case 1:
            cell.settingsLabel.text =
                apis[indexPath.row]
        case 2:
            cell.settingsLabel.text = socialMedia[indexPath.row]
        default:
            cell.settingsLabel.text = devTeam[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // tableView should be connected as an IBOutlet
        

        //let detailsViewController = segue.destination as! AboutDetailsVC
       // detailsViewController.receivedData = dataToSend
    }

        //...
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
