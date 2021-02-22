//
//  PopularMoviesCollectionViewController.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

import UIKit

class PopularMoviesCollectionViewController: UICollectionViewController {
    
    private var presenter: PopularMoviePresenter!
    
    private let itemsPerRow:CGFloat = 3
    private let sectionInserts = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 10)
    private var movies: [MovieModel]?
    private var selectedMovie : MovieModel?
    
    private var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Find Movies..."
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PopularMoviePresenter(view: self)
        presenter.getPopularMovies()
        //Header
        self.collectionView!.register(PopularMovieTitleCollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: PopularMovieTitleCollectionReusableView.identifier)
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = movies else { return 0}
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movies = movies else { return UICollectionViewCell()}
        let movie = movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.identifier, for: indexPath) as! PopularMovieCollectionViewCell
        cell.dropShadow()
        cell.configure(with: movie)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()}
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PopularMovieTitleCollectionReusableView.identifier, for: indexPath) as! PopularMovieTitleCollectionReusableView
        return sectionHeader
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = movies?[indexPath.row] else {return}
        self.presenter.navigateToMovieDetail(movie: movie)
    }
    
    func navigateToMovieDetails(movie: MovieModel) {
        selectedMovie = movie
        self.performSegue(withIdentifier: "toMovieDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toMovieDetail"){
            let data = segue.destination as! MovieDetailViewController
            data.movie = selectedMovie
        }
    }

}


extension PopularMoviesCollectionViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSegue(withIdentifier: "toSearchMovie", sender: self)
    }
}


extension PopularMoviesCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem*4.5/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.top
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}


extension PopularMoviesCollectionViewController: PopularView{
    
    func showPopularMovies(movies: [MovieModel]) {
        self.movies = movies
        collectionView.reloadData()
    }
}
