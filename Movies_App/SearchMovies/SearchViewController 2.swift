//
//  SearchViewController.swift
//  Movies_App
//
//  Created by Anastasia on 16.02.2021.
//

import UIKit


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SearchView, IndicatorShowable{
    
    var presenter: SearchPresenter!
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var selectedMovie : MovieModel?
    private var searchHistory = [String]()
    private var searchResult: [MovieModel]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(view: self)
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
     
    }
   
   
    // MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = searchResult{
            return results.count
        } else{
            return searchHistory.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let _ = searchResult{
            return "Search Results"
        } else{
            return "Last Searches"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movies = searchResult else {
            let historyItem = searchHistory[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "🕒 \(historyItem)"
            return cell
        }
        
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath) as! SearchMovieTableViewCell
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let movies = searchResult else {
            let historyItem = searchHistory[indexPath.row]
            searchBar.text = historyItem
            presenter.onSearch(historyItem)
            searchBar.resignFirstResponder()
            return
        }
        let movie = movies[indexPath.row]
        self.presenter.navigateToMovieDetail(movie: movie)
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromSearchToDetail"){
            let data = segue.destination as! MovieDetailViewController
            data.movie = selectedMovie
        }
    }
    
    func navigateToMovieDetails(movie: MovieModel) {
        selectedMovie = movie
        self.performSegue(withIdentifier: "fromSearchToDetail", sender: self)
    }
    
    // MARK:- SearchView
    func showHistory(lastSearchedMovies: [String]) {
        searchHistory = lastSearchedMovies
    }
    
    func showSearchResults(movies: [MovieModel]) {
        searchResult = movies
        tableView.reloadData()
    }
    
    // MARK:- Search Bar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResult = nil
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        presenter.onSearch(searchBar.text)
        presenter.updateHistory()
        searchBar.resignFirstResponder()
      
    }
    
}
