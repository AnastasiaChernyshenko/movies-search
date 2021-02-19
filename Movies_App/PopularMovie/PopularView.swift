//
//  PopularView.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

protocol PopularView: IndicatorShowable, AlertShowable {
    func showPopularMovies(movies: [MovieModel])
    func navigateToMovieDetails(movie: MovieModel) 
}
