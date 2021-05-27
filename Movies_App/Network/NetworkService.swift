//
//  NetworkService.swift
//  Movies_App
//
//  Created by Anastasia on 14.02.2021.
//

import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private let baseURL = "https://api.themoviedb.org/3"
    
    let storage: Storage
    
    init(storage: Storage = .init()) {
        self.storage = storage
    }
    
    func getLastSearchResults(onSuccess: @escaping ([String]) -> Void) {
        onSuccess(storage.getSuggestions())
    }
    
    func searchMovies(with query: String, onSuccess: @escaping ([MovieModel]) -> Void, onError: @escaping (String) -> Void) {
        let queryEncoded = query.urlEncode()
        let searchRequest = baseURL + ExternalLinks.movieSearch + "?query=\(queryEncoded)&"
        sendMoviesRequest(for: searchRequest, onSuccess: onSuccess, onError: onError)
        self.storage.add(suggestion: query)
    }
    
    func similarMovies(with id: Int, onSuccess: @escaping ([MovieModel]) -> Void, onError: @escaping (String) -> Void) {
        let searchRequest = baseURL + ExternalLinks.getSimilarMoviesLink(movieId: id) + "?"
        sendMoviesRequest(for: searchRequest, onSuccess: onSuccess, onError: onError)
    }
    
    func popularMovies(onSuccess: @escaping ([MovieModel]) -> Void, onError: @escaping (String) -> Void) {
        let searchRequest = baseURL + ExternalLinks.popularMovies + "?"
        sendMoviesRequest(for: searchRequest, onSuccess: onSuccess, onError: onError)
    }
    
    private func sendMoviesRequest(for requestString: String, onSuccess: @escaping ([MovieModel]) -> Void, onError: @escaping (String) -> Void){
        let requestWithKey = requestString+"api_key=8bacc480e8a0b8b63aec4d7df24bd9e9"
        AF.request(requestWithKey).responseJSON { response in
            guard let JSON = response.value as? [String: AnyObject],
                  let jsonArray = JSON["results"] as? [[String: AnyObject]],
                  let movies: [MovieModel] = MovieModel.deserialize(with: jsonArray), !movies.isEmpty else {
                onError("Not Found")
                return
            }
            onSuccess(movies)
        }
    }
}
