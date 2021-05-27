//
//  PopularMovieModel.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

import Unbox

final class MovieModel: Unboxable {
    
    var id: Int
    var originalTitle: String
    var overview: String
    var popularity: Double
    var voteAverage: Double
    var voteCount: Int
    var backdrop: String
    var poster:  String
    var releaseDate: Date
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        originalTitle = (try? unboxer.unbox(key: "original_title")) ?? ""
        overview = (try? unboxer.unbox(key: "overview")) ?? ""
        popularity = (try? unboxer.unbox(key: "popularity")) ?? 0
        voteAverage = (try? unboxer.unbox(key: "vote_average")) ?? 0
        voteCount = (try? unboxer.unbox(key: "vote_count")) ?? 0
        backdrop = (try? unboxer.unbox(key: "backdrop_path")) ?? ""
        poster = (try? unboxer.unbox(key: "poster_path")) ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        releaseDate = dateFormatter.date(from: (try? unboxer.unbox(key: "release_date")) ?? "") ?? Date()
    }
    
    static func deserialize(with jsonArray: [[String: AnyObject]]) -> [MovieModel]? {
        return try? unbox(dictionaries: jsonArray, allowInvalidElements: true)
    }
    
}


