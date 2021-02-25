//
//  MovieDetailPresenter.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

import Foundation

class MovieDetailPresenter {
    
     weak var view: MovieDetailView?
     var movie: MovieModel
    
    init(view: MovieDetailView, movie: MovieModel) {
        self.view = view
        self.movie = movie
    }
    
    func onViewDidLoad() {
        view?.detailOf(movie: movie)
    }
}
