//
//  MovieListObservableObject.swift
//  SwiftUIMovieDB
//
//  Created by Alfian Losari on 22/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

//import SwiftUI

import Foundation

class MovieListState {
    
    var delegate: MovieDelegate?
    //@Published
    var movies: [Movie]?
    //@Published
    var isLoading: Bool = false
    //@Published
    var error: NSError?

    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMoviesFromTrending(with endpoint: MovieListEndpoint, completion: @escaping ([Movie]) -> ()) {
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchTrendingMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                self.loadImages(to: response.results)
                completion(response.results)
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func loadMovies(with endpoint: MovieListEndpoint, completion: @escaping ([Movie]) -> ()) {
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                self.loadImages(to: response.results)
                completion(response.results)
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    
    func loadImages(to movies: [Movie]) {
       
            DispatchQueue.global().async {
            
                for movie in movies {
                
                    guard let url = movie.posterURL else { return }
                
                 movie.imageData = try? Data(contentsOf: url)
           
                }
                
                DispatchQueue.main.async {
                    self.delegate?.imageUpdated()
                }
               
        }
        
    }
    
}

