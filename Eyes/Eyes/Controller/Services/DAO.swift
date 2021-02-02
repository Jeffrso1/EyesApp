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

protocol DAOSearch {
    
    func search()
}

class DAO: MovieDelegate {    
    
    let movieListState = MovieListState()
    let movieDetailState = MovieDetailState()
    let movieLoadingState = MovieLoadingDetailState()
    let movieSearchState = MovieSearchState()
    
    var movies : [Int : Movie] = [:]
    
    var popular = [Movie]()
    var trending = [Movie]()
    var nowPlaying = [Movie]()
    var upComing = [Movie]()
    var topRated = [Movie]()
    
    var isMovieListsLoaded : Bool = false
    
    var moviesArray = [Movie]()
    
    var selectedMovie: Movie?
    
    var myMovies: [Int : MyMovie] = [:]
    
    var favoriteMovies : [Int : Movie] = [:]
    
    var searchedMovies : [Int : Movie] = [:]
    
    var currentMovie : Int = 0
    
    var movie: Movie?
    
    var tags : [Tag] = []
    var movieCK : MyMovie?
    
    var movieDetails : Movie? {
       return movieLoadingState.movie
    }
    
    var movieList : [Movie] {
        return movieListState.movies ?? []
    }
    
    fileprivate init() {
        loadTags()
        loadTagsSelected()
    }
    
    func loadMovies(to caller: DAORequester?, from endpoint: MovieListEndpoint) {
        
        movieListState.loadMovies(with: endpoint) { movies in
            
            self.loadMovieLocalized(movies: movies, completion: { movies in
               
                for movie in movies {
                
                    switch endpoint {
                    case .nowPlaying:
                        self.nowPlaying.append(movie)
                    case .upcoming:
                        self.upComing.append(movie)
                    case .topRated:
                        self.topRated.append(movie)
                    case .popular:
                        self.popular.append(movie)
                    case .trendingWeek:
                        self.trending.append(movie)
                    }
                }
     
                caller?.updated()
                    
            })
            
            
 
        }
        
        
        
    }
    
    func loadMoviesFromTrending(to caller: DAORequester?) {
        
        movieListState.loadMoviesFromTrending(with: .trendingWeek) { movies in
            
            self.loadMovieLocalized(movies: movies, completion: { movies in
               
                for movie in movies {
                    
                    self.movies[movie.id] = movie
                    
                }
               
                caller?.updated()
            })
 
        }
    }
    
    func loadMovie(movie: Int, to caller: DAORequester?)  {
        
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
    
    func loadTags(to caller: DAORequester? = nil) {
        
        Tag.ckLoadAll(then: {result in
            
            switch result {
            case .success(let result):
                self.tags = result as! [Tag]
                caller?.updated()
                //CKMDefault.semaphore.signal()
            case .failure(let error):
                print(error)
               //CKMDefault.semaphore.signal()
            }
            
        })
        
        //CKMDefault.semaphore.wait()
        print("Final Tags: \(tags)")
        //return tags
        
    }
    
    func loadTagsSelected() -> [TagSelected] {
        
        var tags: [TagSelected] = []
        
        TagSelected.ckLoadAll(then: {result in
            
            switch result {
            case .success(let result):
                tags = result as! [TagSelected]
                CKMDefault.semaphore.signal()
            case .failure(let error):
                print(error)
                CKMDefault.semaphore.signal()
            }
            
        })
        
        CKMDefault.semaphore.wait()
        return tags
        
    }
    
    func loadMovieCK(with movieID: String, to caller: DAORequester) {
       
        guard let movieID = Int(movieID) else { return }
        
        if let _ = myMovies[movieID] {
            caller.updated()
            return
        }
        
        MyMovie.ckLoad(with: String(movieID), then: {result in
            
            switch result {
            case .success(let result):
                self.myMovies[movieID] = result as! MyMovie
                caller.updated()
            case .failure(let error):
                print("NAO FUNCIONA")
            }
            
        })

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
    
    
    func searchMovies(to caller: DAORequester?, query: String) {
        
        movieSearchState.search(query: query) { movies in
                
            for movie in movies {
            
                self.searchedMovies[movie.id] = movie
                
            }
                caller?.updated()
            }
        
    }
    
    func searchMovieLocalized(movie: [Movie], to caller: DAOSearch?) {
        
        loadMovieLocalized(movies: movie, completion: { movies in
           
            for movie in movies {
                self.selectedMovie = movie
            }
            
            caller?.search()
            
        })
    }
    
    func loadFavoritesMovies(IDs: [Int], to caller: DAORequester?) {
        
        for id in IDs {
            
            movieLoadingState.loadMovie(id: id) { movie in
                
                if self.favoriteMovies[id] != movie {
                    
                    self.favoriteMovies[movie.id] = movie
                    
                }
                
                caller?.updated()
                
            }
        }
    }
    
    func passMovie(movie: Movie) {
        
    }
    
    func fetchMovies(movies: [Movie]) {
        
    }
    
    func imageUpdated() {
        
    }
    
    
    
}
