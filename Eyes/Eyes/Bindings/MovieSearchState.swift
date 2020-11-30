//
//  MovieSearchState.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 24/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

//import SwiftUI
import Combine
import Foundation

class MovieSearchState {
    
    @Published var query = ""
    var movies: [Movie]?
    var isLoading = false
    var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    let movieService: MovieService
    
    /*
     Handles empty results. Could be more precise!
    */
    
    var isEmptyResults: Bool {
        !self.query.isEmpty && self.movies != nil && self.movies!.isEmpty
    }
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    /*
     Starts observing search!
    */

    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                self?.movies = nil
                self?.error = nil
                return text
                
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) { movies in} }
    }
 
    
    
    func search(query: String, completion: @escaping ([Movie]) -> ()) {
        //self.movies = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty else {
            return
        }
        
        self.isLoading = true
        self.movieService.searchMovie(query: query) {[weak self] (result) in
            guard let searchResult = self else { return }
            searchResult.isLoading = false
            switch result {
            case .success(let response):
                //self.movies = response.results
                completion(response.results)
            case .failure(let error):
                searchResult.error = error as NSError
            }
        }
    }
    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}


//searchResult.query == query
