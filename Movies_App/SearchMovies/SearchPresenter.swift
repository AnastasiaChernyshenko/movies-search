//
//  SearchPresenter.swift
//  Movies_App
//
//  Created by Anastasia on 16.02.2021.
//

class SearchPresenter {
    
    private weak var view: SearchView?
    
    init(view: SearchView) {
        self.view = view
    }
    
    func onViewWillAppear() {
        updateHistory()
    }
    
    func onSearch(_ query: String?) {
        guard let query = query else { return }
        view?.showLoadingIndicator()
        NetworkService.shared.searchMovies(with: query, onSuccess: { [weak self] movies in
            self?.view?.hideLoadingIndicator()
            self?.view?.showSearchResults(movies: movies)
        }, onError: { [weak self] message in
            self?.view?.hideLoadingIndicator()
            self?.view?.showAlert(message: message)
        })
    }
    
    func onSelect(movie: MovieModel){
        view?.selectedMovie?(movie)
    }
    
    func updateHistory() {
        NetworkService.shared.getLastSearchResults { [unowned self] results in
            guard !results.isEmpty else { return }
            self.view?.showHistory(lastSearchedMovies: results)
        }
    }
}
