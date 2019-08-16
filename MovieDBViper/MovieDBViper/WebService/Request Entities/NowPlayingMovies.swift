//
//  NowPlayingMovies.swift
//  MovieDBViper
//
//  Created by Pedro Enrique Sobrosa Lopes on 15/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

// MARK: - Use this code to save at this struct
//   let nowPlayingMovie = try? newJSONDecoder().decode(NowPlayingMovies.self, from: jsonData)

import Foundation

// MARK: - NowPlayingMovies
struct NowPlayingMovies: Codable {
    let results: [Result]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}
