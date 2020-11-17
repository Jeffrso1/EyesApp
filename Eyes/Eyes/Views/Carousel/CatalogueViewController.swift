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
    
//    private var connectionSegue: UIStoryboardSegue!
    
    @IBAction func showDetails(_ sender: UIButton) {
   
    
    }
    
    @IBAction func reviewMoview(_ sender: Any) {
        
        if FileManager.default.ubiquityIdentityToken != nil {
            
            print("iCloud Available")
            
            performSegue(withIdentifier: "movieReview", sender: self)
                
            print("Review Movie pressed")
            
        } else {
            print("iCloud Unavailable")
            
            Alert.showBasic(title: NSLocalizedString("iCloud Not Logged In", comment: ""), message: NSLocalizedString("Please, go to the Settings app on your iPhone and login to iCloud to review", comment: "") , vc: self, type: .error)
        }
        
    }
    
    
    
    var currentPage : Int = 0
//    let pageViewController = PageViewController()
    var selectedID : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.connectionSegue = UIStoryboardSegue(identifier: "ConnectionSegue", source: CatalogueViewController, destination: ConnectionViewController) {
//            self.connectionSegue.source.showDetailViewController(self.connectionSegue.destination, sender: self)
//        }
        
        monitorNetwork()
        configNavBar()
    }
    
    func configNavBar() {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.3

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if dao.currentMovie != 0 {
        
        if segue.identifier == "movieDetails" {
            let vc = segue.destination as! MovieDetailsViewController
            selectedID = Array(dao.movies)[dao.currentMovie].key
            vc.movieID = selectedID
                
            print("Details Button pressed")
        }
        
        if segue.identifier == "about" {
            let vc = segue.destination as! AboutAppViewController
            vc.navigationController?.navigationBar.prefersLargeTitles = true
                
            print("About Section pressed")
        }
        
        }
        
    }
    
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    print("adasdaadsasd")
                }
                
            }
            else if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    Alert.showBasic(title: "Ocorreu um problema na conexão com o servidor", message: "Por favor, tente novamente mais tarde", vc: self, type: .warning)
                }
                
            }
        }
        
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    @IBAction func backToCatalogue( _ segue: UIStoryboardSegue) {
        
        
    }
    
    
    
  
    
    
}
