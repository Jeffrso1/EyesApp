//
//  EndReviewViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 28/10/20.
//

import UIKit


protocol CarouselUpdater {
    
    func updateCarousel()
    
}

class EndReviewViewController: UIViewController, UIPageViewControllerDelegate {
    
    var delegate: CarouselUpdater?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove left buttons (in case you added some)
         self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
         self.navigationItem.hidesBackButton = true
        
    }

    @IBAction func goToHomeScreen(_ sender: Any) {
   
        delegate?.updateCarousel()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if let vc2 = segue.destination as? CarouselPageVC{
            vc2.delegate = self
        }
        
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
