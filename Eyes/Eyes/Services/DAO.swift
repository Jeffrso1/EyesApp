//
//  DAO.swift
//  Eyes
//
//  Created by Lucas Frazão on 20/10/20.
//

import Foundation

let dao = DAO()

protocol DAORequester {
    
    func updated()
    
}


class DAO: MovieDelegate {
 
    
    let movieListState = MovieListState()
    let movieDetail = MovieDetailState()
    
    var movies : [Int : Movie] = [:]
    var movieList : [Movie] {
        return movieListState.movies ?? []
    }
    
    fileprivate init() {
      
    }
    
    func loadMovies(to caller: DAORequester?) {
    
        movieListState.loadMovies(with: .trendingWeek) { movies in
            
            for movie in movies {
                
                self.movies[movie.id] = movie
             
            }
            
            caller?.updated()
        }
      
    }
    
    func passMovie(movie: Movie) {
        
        movieDetail.loadMovie(id: movie.id) { movie in
            
            if let movie = movie {
                
            }
            
        }
        
       //movieDetail.loadMovie(id: , to: self)
        
    }
    
    func fetchMovies(movies: [Movie]) {
        
    }
    
    func imageUpdated() {
        
    }
   
}
