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
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageLoader = ImageLoader()
    
    var lastOffsetY :CGFloat = 0

    var alpha : CGFloat = 0.0
    
    @IBOutlet weak var optionsButton: UIBarButtonItem!
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    @IBAction func optionsButton(_ sender: Any) {
        
        let shareViewController = ShareImage(movie: currentMovie!)
        
        let renderer = UIGraphicsImageRenderer(size: shareViewController.view.bounds.size)
        let image = renderer.image { ctx in
            shareViewController.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        Alert.showMovieOptions(vc: self, image: image)
    }
    
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
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
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
           // self.navigationController?.navigationBar.alpha = 0.8
                
            }, completion: nil)
        }
        
        
    }
    
    
    
    
    
    func updated() {
        
        //        movieImage.image = imageID
        
    }
    
}
