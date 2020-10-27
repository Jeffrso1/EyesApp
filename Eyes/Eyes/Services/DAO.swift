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
    let movieLoadingState = MovieLoadingDetailState()
    
    var movies : [Int : Movie] = [:]
    
    var movie: Movie?
    
   // var moviesLocalized: [Movie?] = []
    
    var movieDetails : Movie? {
       return movieLoadingState.movie
    }
    
    var movieList : [Movie] {
        return movieListState.movies ?? []
    }
    
    fileprivate init() {
        
    }
    
    func loadMovies(to caller: DAORequester?) {
        
        movieListState.loadMovies(with: .trendingWeek) { movies in
            
            self.loadMovieLocalized(movies: movies, completion: { movies in
               
                for movie in movies {
                    
                    self.movies[movie.id] = movie
                    
                }
               
                caller?.updated()
            })
 
        }
        
    }
    
    
//    func loadMovie(movie: Movie, completion: ()->Void)  {
//
//        var result: Movie?
//
//        movieDetailState.loadMovie(id: movie.id) { movie in
//
//            //self.movie = movie
//
//            //movieDetail = movie
//
//           // caller?.updated()
//
//        }
//
//    }
//
    func loadMovie(movie: Int, to caller: DAORequester?)  {
        
        //var result: Movie?
        
        movieLoadingState.loadMovie(id: movie) { movie in
            
            self.movie = movie
            
            caller?.updated()
            
        }
        
    }
    
    func loadMovieLocalized(movies: [Movie], completion: @escaping ([Movie])-> Void) {
        
        var results: [Result<Movie, MovieError>] = []
        
        for movie in movies {
            
            movieDetailState.loadMovie(id: movie.id) { result in
                
                results.append(result)
                print(results.count)
                
                if results.count == movies.count {
                    var movies : [Movie] = []
                    for item in results {
                        switch item {
                        case .success(let movie):
                            movies.append(movie)
                        case .failure(let err):
                            print(err)
                        }
                    }
                    completion(movies)
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
    
    func fetchMovies(movies: [Movie]) {
        
    }
    
    func imageUpdated() {
        
    }
    
}
