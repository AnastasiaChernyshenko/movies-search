//
//  MovieDetailView.swift
//  Movies_App
//
//  Created by Anastasia on 25.02.2021.
//

protocol MovieDetailView: IndicatorShowable, AlertShowable, Presentable {
    func detailOf(movie: MovieModel)
}
