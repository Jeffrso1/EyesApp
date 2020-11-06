//
//  AboutBechdelTestVC.swift
//  Eyes
//
//  Created by Lucas Frazão on 27/10/20.
//

import UIKit

class AboutBechdelTestVC: UIViewController {

    @IBOutlet weak var whatBechdelTest: UITextView!
    @IBOutlet weak var impactIndustry: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        whatBechdelTest.text = NSLocalizedString("BechdelTest", comment: "")
        impactIndustry.text = NSLocalizedString("ImpactIndustry", comment: "")
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
