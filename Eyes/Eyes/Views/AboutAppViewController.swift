//
//  AboutAppViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 29/10/20.
//

import UIKit

class AboutAppViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("eu")
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath as! IndexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Third-Party APIs"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // tableView should be connected as an IBOutlet
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            print("Something went wrong when selected a row!")
            return
        }

        if selectedIndexPath.section == 0 { // Account Section

            if selectedIndexPath.row == 0 { // Name Row
                //dataToSend = "name"
            } else if selectedIndexPath.row == 1 { // School Row
                //dataToSend = "school"
            } else if selectedIndexPath.row == 2 { // Grade Row
               //dataToSend = "grade"
            }

        } else if selectedIndexPath.section == 1 { // Private Section

            if selectedIndexPath.row == 0 { // Email Row
                //dataToSend = "email"
            } else if selectedIndexPath.row == 1 { // Password Row
               //dataToSend = "password"
            } else if selectedIndexPath.row == 2 { // Phone Number Row
               // dataToSend = "phone"
            }

        }

        let detailsViewController = segue.destination as! AboutDetailsVC
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
