//
//  MovieDetailsViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 21/10/20.
//

import UIKit

class MovieDetailsViewController: UIViewController, DAORequester {
   
    var movieID: Movie?
    
    var imageLoader = ImageLoader()
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dao.loadMovie(movie: movieID ?? Movie.stubbedMovie, to: self)
        
        movieTitle.text = dao.movie?.title
        movieImage.image = imageLoader.image
       
    }
    
    func updated() {
       
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
