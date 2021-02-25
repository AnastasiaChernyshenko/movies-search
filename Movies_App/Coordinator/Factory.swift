//
//  Factory.swift
//  Movies_App
//
//  Created by Anastasia on 25.02.2021.
//

import UIKit
class Factory {
    func makeSearchModule() -> SearchView {
        let storyboard = UIStoryboard(name: "SearchScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        controller.presenter = SearchPresenter(view: controller)
        return controller
    }
    
    func makeMovieDetailModule(with movie: MovieModel) -> MovieDetailView {
        let storyboard = UIStoryboard(name: "MovieDetailScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        controller.presenter = MovieDetailPresenter(view: controller, movie: movie)
        return controller
    }
    
    func makePopularModule() -> PopularView {
        let storyboard = UIStoryboard(name: "PopularMovieScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PopularMoviesCollectionViewController") as! PopularMoviesCollectionViewController
        controller.presenter = PopularMoviePresenter(view: controller)
        return controller
    }
}
