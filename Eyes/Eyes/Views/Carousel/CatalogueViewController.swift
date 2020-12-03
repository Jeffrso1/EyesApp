//
//  CatalogueViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 22/10/20.
//

import UIKit
import Network

class CatalogueViewController: UIViewController, UIPageViewControllerDelegate {
    
    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //    private var connectionSegue: UIStoryboardSegue!
    
    @IBAction func showDetails(_ sender: UIButton) {
   
        dao.selectedMovie = nil
        
    }
    
    let scrollView: UIScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .clear
            return v
    }()
    
    @IBAction func reviewMoview(_ sender: Any) {
        
        if FileManager.default.ubiquityIdentityToken != nil {
            
            print("iCloud Available")
            
            performSegue(withIdentifier: "movieReview", sender: self)
                
            print("Review Movie pressed")
            
        } else {
            print("iCloud Unavailable")
            
            Alert.showBasic(title: NSLocalizedString("iCloud Not Logged In", comment: ""), message: NSLocalizedString("Please, go to the Settings app on your iPhone and login to iCloud to review", comment: "") , vc: self, type: .error)
        }
        
        dao.selectedMovie = nil
        
    }
    
    var currentMovie : Movie?
    
    var currentPage : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        
        monitorNetwork()
        navigationBar.configNavBar(view: self)
        self.navigationController?.navigationItem.hidesBackButton = true
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if dao.currentMovie != 0 {
            
        if segue.identifier == "movieReview" {
            
            print("Bechdel Test Button pressed")
        }
        
        if segue.identifier == "movieDetails" {
            
                
            print("Details Button pressed")
        }
        
        if segue.identifier == "about" {
            //let vc = segue.destination as! AboutAppViewController
            //vc.navigationController?.navigationBar.prefersLargeTitles = true
                
            print("About Section pressed")
        }
        
        }
        
    }
    
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    
                }
                
            }
            else if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    Alert.showBasic(title: NSLocalizedString("A problem has occurred with the connection", comment: ""), message: NSLocalizedString("Please, try again later.", comment: ""), vc: self, type: .warning)
                }
                
            }
        }
        
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    @IBAction func backToCatalogue( _ segue: UIStoryboardSegue) {
        
        
    }
    
    
    
  
    
    
}
