//
//  PopularMoviePresenter.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

class PopularMoviePresenter {
    
    private weak var view: PopularView?
    
    init(view: PopularView) {
        self.view = view
    }
   
    func onSelect(movie: MovieModel){
        view?.selectedMovie?(movie)
    }
    
    func navigateToSearch(){
        view?.toSearch?()
    }
    
    func getPopularMovies(){
        NetworkService.shared.popularMovies(onSuccess: { [weak self] movies in
            self?.view?.showPopularMovies(movies: movies)
        }, onError: { [weak self] _ in
            self?.view?.showAlert(message: "Can't load data")
        })
    }
}
