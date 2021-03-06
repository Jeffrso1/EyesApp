//
//  MovieDetailState.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 24/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

//import SwiftUI
import Foundation

public class MovieDetailState {
    
    var delegate: MovieDelegate?
    
    private let movieService: MovieService
    var movie: Movie?
    public var isLoading = false
    public var error: NSError?
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    /*
     Load a single movie using its unique identifier
    */
 
    func loadMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        //self.movie = nil
        self.isLoading = true
        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            completion(result)
        }
    }
    
    func loadImage(to movie: Movie) {
       
            DispatchQueue.global().async {
            
                guard let url = movie.posterURL else { return }
                
                 movie.imageData = try? Data(contentsOf: url)
           
                DispatchQueue.main.async {
                    self.delegate?.imageUpdated()
                }
               
        }
        
    }
    
    
    
}
