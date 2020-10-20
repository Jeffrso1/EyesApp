//
//  ViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 19/10/20.
//

import UIKit

protocol MovieDelegate {
    
    func passMovie(movie: Movie)
    func fetchMovies(movies: [Movie])
    func imageUpdated()
}

protocol ImageDelegate {
    
    func imageLoader(image: UIImage)
    
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DAORequester {
  
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        collectionView.delegate = self
        collectionView.dataSource = self
    
        dao.loadMovies(to: self)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
        collectionView.reloadData()
        
    }
  
    func updated() {
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MoviesCollectionViewCell
        
        
        if let data = dao.movieList[indexPath.row].imageData {
        
            cell.imageView.image =  UIImage(data: data)
            
            
        } else {
         
            cell.imageView.image = UIImage(named: "wait")
      
        }
        
        
        dao.loadMovie(movie: dao.movieList[indexPath.row], to: self)
        
        overview.text = dao.movie?.overview
        movieTitle.text = dao.movie?.title
     
        //cell.movieTitle.text = dao.movieList[indexPath.row].title
     
        return cell
    }
 
    
    //Centralized Collection View Cell
    
    var itemCellSize : CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    var itemCellsGap: CGFloat = 0

     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = (itemCellSize.width + itemCellsGap)
        let itemIndex = (targetContentOffset.pointee.x) / pageWidth
        targetContentOffset.pointee.x = round(itemIndex) * pageWidth - (itemCellsGap / 2)
    }

    // CollectionViewFlowLayoutDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemCellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemCellsGap
    }
 
}

