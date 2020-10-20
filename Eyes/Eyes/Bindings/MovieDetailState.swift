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
    
    
    
    private let movieService: MovieService
    //@Published
    var movie: Movie?
    //@Published
    public var isLoading = false
   // @Published
    public var error: NSError?
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    /*
     Load a single movie using its unique identifier
    */
 
    func loadMovie(id: Int, completion: @escaping (Movie?) -> ()) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
                completion(movie)
                //self.delegate?.passMovie(movie: movie, to:)
            case .failure(let error):
                self.error = error as NSError
                completion(nil)
            }
        }
    }
}
