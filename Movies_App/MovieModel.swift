//
//  PopularMovieModel.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

import UIKit
import Alamofire

class MovieModel {
    
    var id: Int{
        return movie.id ?? 0
    }
    var originalTitle: String {
        return movie.originalTitle ?? ""
    }
    
    var overview: String {
        return movie.overview ?? "not set"
    }
    
    var popularity: Float{
        return movie.popularity ?? 0.0
    }
    
    var voteAverage: Float{
        return movie.voteAverage ?? 0.0
    }
    
    var voteCount: Int{
        return movie.voteCount ?? 0
    }
    
    var backdrop: String{
        return movie.backdrop
    }
    
    var poster: String{
        return movie.poster
    }
    
    var releaseDate: String{
        return movie.releaseDate
    }
    
    var image: UIImage?
    
    private let movie: Movie
    
    init(with movie: Movie) {
        self.movie = movie
    }
    
    func loadImage(onSuccess: @escaping (UIImage?) -> Void) {
        guard image == nil else { onSuccess(image); return }
        let path = movie.poster
        sendRequest(path: path, onSuccess: onSuccess)
    }
    
    func loadBackdrop(onSuccess: @escaping (UIImage?) -> Void) {
        guard image == nil else { onSuccess(image); return }
        let path = movie.backdrop
        print(path)
        sendRequest(path: path, onSuccess: onSuccess)
    }
    
    private func sendRequest(path: String, onSuccess: @escaping (UIImage?) -> Void){
        let request = AF.request(path)
        request.responseData { [weak self] response in
            guard let data = response.value else { return }
            self?.image = UIImage(data: data)
            onSuccess(self?.image)
        }
    }

}


