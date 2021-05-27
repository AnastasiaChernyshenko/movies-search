//
//  SearchViewController.swift
//  Movies_App
//
//  Created by Anastasia on 16.02.2021.
//

import UIKit


class SearchViewController: UIViewController{
    
    var presenter: SearchPresenter!
    var selectedMovie: ((MovieModel) -> Void)?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
 
    private var searchHistory = [String]()
    private var searchResult: [MovieModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(view: self)
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    
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
        presenter.onSelect(movie: movie)
    }
}


extension SearchViewController: UISearchBarDelegate{
    
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


extension SearchViewController: SearchView, IndicatorShowable{
  
    func showHistory(lastSearchedMovies: [String]) {
        searchHistory = lastSearchedMovies
    }
    
    func showSearchResults(movies: [MovieModel]) {
        searchResult = movies
        tableView.reloadData()
    }
}
