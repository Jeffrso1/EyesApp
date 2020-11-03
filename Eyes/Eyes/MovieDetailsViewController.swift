//
//  MovieDetailsViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 21/10/20.
//

import UIKit

class MovieDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, DAORequester {
    
    var movieID: Int?
    var imageID: UIImage?
    
    //let navBarHeight: CGFloat = 66.0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageLoader = ImageLoader()
    
    var lastOffsetY :CGFloat = 0

    var alpha : CGFloat = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInsetAdjustmentBehavior = .never
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var cell : UICollectionViewCell?
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionViewCell
            
            cell.setupHeaderCell()
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "overview", for: indexPath) as! OverviewCollectionViewCell
            
            cell.setupOverviewCell()
            
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tags", for: indexPath) as! TagsCollectionViewCell
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cast", for: indexPath) as! CastCollectionViewCell
            
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
//            return .init(width: view.frame.width, height: 100)
//        default:
//            return .init(width: view.frame.width, height: 700)
//        }
//    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
                
        let transition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.fade
        
        lastOffsetY = scrollView.contentOffset.y
        
        print(lastOffsetY)
        
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
