//
//  MovieDetailsViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 21/10/20.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, DAORequester {
    
    var movieID: Int?
    var imageID: UIImage?
    
    //@IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var imageLoader = ImageLoader()
    
    var lastOffsetY :CGFloat = 0

    var alpha : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    func updateHeight() {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! HeaderTableViewCell
            
            cell.setupHeaderCell()
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overview", for: indexPath) as! OverviewTableViewCell
            
            cell.setupOverviewCell()
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tags", for: indexPath) as! TagsTableViewCell
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cast", for: indexPath) as! CastListTableViewCell
            
            cell.tableView.reloadData()
            updateHeight()
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "")!
            
            return cell
        }

        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "AccentColor")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch indexPath.row {
//        case 0:
//            return .init(width: view.frame.width, height: 400)
//        case 1:
//            return .init(width: view.frame.width, height: 220)
//        case 2:
//            return .init(width: view.frame.width, height: 300)
//        default:
//            return .init(width: view.frame.width, height: 700)
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
                
        let transition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.fade
        
        lastOffsetY = scrollView.contentOffset.y
        
        //print(lastOffsetY)
        
        if lastOffsetY > 60 {
        
            UIView.animate(withDuration: 0.5, animations: {
               
                self.navigationController?.navigationBar.alpha = 1.0
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
                self.navigationController?.navigationBar.shadowImage = nil
                self.navigationController?.navigationBar.isTranslucent = true
                self.navigationController?.view.backgroundColor = UIColor.black
                
            }, completion: nil)
            
        } else {
          
            
            UIView.animate(withDuration: 0.5, animations: {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            //self.navigationController?.navigationBar.alpha = 0
            }, completion: nil)
        }
        
        
    }
    

    
    func updated() {
        
        //        movieImage.image = imageID
        
    }
    
}
