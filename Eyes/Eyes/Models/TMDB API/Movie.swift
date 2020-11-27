//
//  Movie.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    
    let results: [Movie]
}

/*
    Handles all the data originated from the JSON's API response. This Swift file has all data needed for "Movies". Use another file to add TV Shows.
*/

class Movie: Decodable, Identifiable, Hashable {
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    
    var imageData: Data?
    var imageBackdropData: Data?
    
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    /*
    All formating needs to be localized for other languages!
    */
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath ?? "")")!
    }
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    /*
     You can only search for a movie genre/rating/score/year/duration through its movie ID. Searching from an endpoint will result on an error.
    */
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
  
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }
    
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
    
}

struct MovieGenre: Decodable {
    
    let name: String
}

struct MovieCredit: Decodable {
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

class MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
    var profileImageData: Data?
    let profilePath: String?
    var profileURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(profilePath ?? "")")!
    }
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct MovieVideoResponse: Decodable {
    
    let results: [MovieVideo]
}


/*
    Handles trailers. Already localized.
*/

struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
