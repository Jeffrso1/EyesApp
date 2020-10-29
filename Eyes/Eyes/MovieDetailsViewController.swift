//
//  MovieDetailsViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 21/10/20.
//

import UIKit

class MovieDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DAORequester {
   
    var movieID: Int?
    var imageID: UIImage?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dao.loadMovie(movie: movieID!, to: self)
        
        // Do any additional setup after loading the view.
        //dao.loadMovie(movie: movieID ?? Movie.stubbedMovie, to: self)
        
        //let imageURL = imageLoader.loadImage(with: (movieID?.posterURL ?? Movie.stubbedMovie.posterURL)!)
        
//        movieTitle.text = dao.movie?.title
        //movieImage.image = imageID
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell?
        
        switch indexPath.row {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionViewCell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "overview", for: indexPath) as! OverviewCollectionViewCell
            
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tags", for: indexPath) as! TagsCollectionViewCell
        }
    
        return cell!
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch indexPath.row {
//        case 0:
//            return .init(width: view.frame.width, height: 400)
//        case 1:
//            return .init(width: view.frame.width, height: 200)
//        default:
//            return .init(width: view.frame.width, height: 200)
//        }
//    }
    
    func updated() {
       
//        movieImage.image = imageID
        
    }
    
}
