//
//  DAO.swift
//  Eyes
//
//  Created by Lucas Frazão on 20/10/20.
//

import Foundation
import CloudKitMagicCRUD

let dao = DAO()

protocol DAORequester {
    
    func updated()
    
}

class DAO: MovieDelegate {    
    
    let movieListState = MovieListState()
    let movieDetailState = MovieDetailState()
    
    var movie: Movie?
    
    var moviesLocalized: [Movie?] = []
    
    //var moviesLocalized : [Int : Movie] = [:]
    
    var movieDetails : Movie? {
        return movieDetailState.movie
    }
    
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
    
    
    func loadMovie(movie: Movie, to caller: DAORequester?) -> Movie? {
        
        var movieDetail: Movie?
        
        movieDetailState.loadMovie(id: movie.id) { movie in
            
            self.movie = movie
            
            movieDetail = movie
            
            caller?.updated()
            
        }
        
        return movieDetail
        
    }
    
    func loadMovieLocalized(to caller: DAORequester?) {
        
        for movieDetails in movieList {
            
            movieDetailState.loadMovie(id: movieDetails.id) { movie in
                    
                if self.moviesLocalized.count == 20 {
                    print(self.moviesLocalized)
                } else {
                    self.moviesLocalized.append(movie)
                    caller?.updated()
                }
   
                
            }
  
        }
        
    }
    
    func loadTag(with string: String) -> Tag? {
        
        var tag: Tag?
        
        Tag.ckLoad(with: string, then: {result in
            switch result {
            case .success(let result):
                tag = result as? Tag
                CKMDefault.semaphore.signal()
            case .failure(let error):
                print(error)
                CKMDefault.semaphore.signal()
            }
            
        })
        
        CKMDefault.semaphore.wait()
        return tag
    }
    
    func loadTags() -> [Tag] {
        
        var tags: [Tag] = []
        
        
        Tag.ckLoadAll(then: {result in
            
            switch result {
            case .success(let result):
                tags = result as! [Tag]
                CKMDefault.semaphore.signal()
            case .failure(let error):
                print(error)
                CKMDefault.semaphore.signal()
            }
            
        })
        
        CKMDefault.semaphore.wait()
        print("Final Tags: \(tags)")
        return tags
        
    }
    
    func loadMovieCK(with movieID: String) -> MyMovie? {
        
        var movie : MyMovie?
        
        MyMovie.ckLoad(with: movieID, then: {result in
            
            switch result {
            case .success(let result):
                movie = result as? MyMovie
                CKMDefault.semaphore.signal()
            case .failure(let error):
                print(error)
                CKMDefault.semaphore.signal()
            }
            
        })
        
        CKMDefault.semaphore.wait()
        return movie
        
    }
    
    func loadMoviesCK() -> [MyMovie] {
        
        var movies : [MyMovie] = []
        
        MyMovie.ckLoadAll(then: {result in
            
            switch result {
            case .success(let result):
                movies = result as! [MyMovie]
                CKMDefault.semaphore.signal()
            case .failure(let error):
                print(error)
                CKMDefault.semaphore.signal()
            }
            
        })
        
        CKMDefault.semaphore.wait()
        return movies
    }
    
    
    
    func passMovie(movie: Movie) {
        
    }
    
    /*
     
     func passMovie(movie: Movie) {
     
     movieDetail.loadMovie(id: movie.id) { movie in
     
     //            if let self.movie = movie {
     //
     //            } else {
     //
     //            }
     
     self.movie = movie
     
     }
     
     
     //movieDetail.loadMovie(id: , to: self)
     
     }
     
     */
    
    func fetchMovies(movies: [Movie]) {
        
    }
    
    func imageUpdated() {
        
    }
    
}
