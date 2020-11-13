//
//  AboutBechdelTestVC.swift
//  Eyes
//
//  Created by Lucas Frazão on 27/10/20.
//

import UIKit

class AboutBechdelTestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sections = [[NSLocalizedString("WhatBechdelTest", comment: ""), NSLocalizedString("BechdelTest", comment: "")], [NSLocalizedString("How does it impact the films industry?", comment: ""), NSLocalizedString("ImpactIndustry", comment: "")]]
    

    @IBOutlet weak var whatBechdelTest: UITextView!
    @IBOutlet weak var impactIndustry: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //whatBechdelTest.text = NSLocalizedString("BechdelTest", comment: "")
        //impactIndustry.text = NSLocalizedString("ImpactIndustry", comment: "")
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutBechdel", for: indexPath as IndexPath) as! AboutBechdelTableViewCell
        
        cell.sectionTitle.text = sections[indexPath.row][0]
        
        cell.sectionDesc.text = sections[indexPath.row][1]
        
        return cell
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
