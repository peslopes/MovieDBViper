//
//  PopularMovies.swift
//  MovieDBViper
//
//  Created by Pedro Enrique Sobrosa Lopes on 15/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

// MARK: - Use this code to save at this struct
//   let popularMovie = try? newJSONDecoder().decode(PopularMovies.self, from: jsonData)

import Foundation

struct PopularMovies: Codable {
    let page, totalResults, totalPages: Int?
    let results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
