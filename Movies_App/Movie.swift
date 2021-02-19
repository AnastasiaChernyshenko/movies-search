//
//  SearchResult.swift
//  Movies_App
//
//  Created by Anastasia on 13.02.2021.
//

import Unbox

struct Movie: Unboxable {
    private let backdropPath: String?
    private let posterPath: String?
    private let releaseDateUnformatted: String?
    
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let popularity: Float?
    let voteAverage: Float?
    let voteCount: Int?
    
    var backdrop: String {
        guard let backdropPath = backdropPath else {return ""}
        return ExternalLinks.forImage+backdropPath
    }
    
    var poster: String {
        guard let posterPath = posterPath else {return ""}
        return ExternalLinks.forImage+posterPath
    }
    
    var releaseDate: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"
        
        guard let releaseDateUnformatted = releaseDateUnformatted,
              let date = dateFormatterGet.date(from: releaseDateUnformatted) else { return "Unknowned"}
        return dateFormatterPrint.string(from: date)
    }
    
    init(unboxer: Unboxer) throws {
        id = try? unboxer.unbox(key: "id")
        backdropPath = try? unboxer.unbox(key: "backdrop_path")
        originalTitle = try? unboxer.unbox(key: "original_title")
        overview = try? unboxer.unbox(key: "overview")
        popularity = try? unboxer.unbox(key: "popularity")
        releaseDateUnformatted = try? unboxer.unbox(key: "release_date")
        posterPath = try? unboxer.unbox(key: "poster_path")
        voteAverage = try? unboxer.unbox(key: "vote_average")
        voteCount = try? unboxer.unbox(key: "vote_count")
    }
    
    static func deserialize(with jsonArray: [[String: AnyObject]]) -> [Movie]? {
        return try? unbox(dictionaries: jsonArray, allowInvalidElements: true)
    }
}



