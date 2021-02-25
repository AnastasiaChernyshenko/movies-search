//
//  PopularView.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

protocol PopularView: IndicatorShowable, AlertShowable, Presentable {
    var toSearch: (() -> Void)? { get set }
    var selectedMovie: ((MovieModel) -> Void)? { get set }
    func showPopularMovies(movies: [MovieModel])
}
