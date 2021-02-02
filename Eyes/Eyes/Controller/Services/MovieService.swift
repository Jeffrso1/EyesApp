//
//  MovieService.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

protocol MovieService {
    
    //All functions to fetch movies and search
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchTrendingMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

enum MovieListEndpoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    //Endpoints used by the API
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    case trendingWeek = "trending/movie/week"
    
    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
            case .trendingWeek: return "Trending Weekly"
        }
    }
}

enum MovieError: Error, CustomNSError {
    
    
    //Handles all errors in the API - Needs fine-tuning!
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}

