//
//  SEarchView.swift
//  Movies_App
//
//  Created by Anastasia on 16.02.2021.
//
protocol SearchView: IndicatorShowable, AlertShowable {
    func navigateToMovieDetails(movie: MovieModel) 
    func showHistory(lastSearchedMovies: [String])
    func showSearchResults(movies: [MovieModel])
}
