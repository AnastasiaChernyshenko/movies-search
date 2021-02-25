//
//  AppCoordinator.swift
//  Movies_App
//
//  Created by Anastasia on 25.02.2021.
//

class AppCoordinator: Coordinator {
    
    private let router: Router
    private let factory: Factory
    
    init(router: Router, factory: Factory = .init()) {
        self.router = router
        self.factory = factory
    }
    
    func start() {
        showPopularMoviesModule()
    }
    
    private func showSearchModule() {
        let searchModule = factory.makeSearchModule()
        searchModule.selectedMovie = { [weak self] movie in
            self?.showMovieDetails(with: movie)
        }
        router.push(searchModule)
    }
    
    private func showMovieDetails(with movie: MovieModel) {
        let detailModule = factory.makeMovieDetailModule(with: movie)
        router.push(detailModule)
    }
    
    private func showPopularMoviesModule() {
        let popularModule = factory.makePopularModule()
        popularModule.selectedMovie = { [weak self] movie in
            self?.showMovieDetails(with: movie)
        }
        popularModule.toSearch = { [weak self]  in
            self?.showSearchModule()
        }
        router.setRootModule(popularModule)
    }
    
}
