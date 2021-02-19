//
//  URL.swift
//  Movies_App
//
//  Created by Anastasia on 13.02.2021.
//

struct ExternalLinks {
    
    static let popularMovies = "/movie/popular"
    static let movieSearch = "/search/movie"
    static let forImage = "https://image.tmdb.org/t/p/w92"
    
    static func getSimilarMoviesLink(movieId: Int) -> String {
        return "/movie/\(movieId)/similar"
    }
    
}
