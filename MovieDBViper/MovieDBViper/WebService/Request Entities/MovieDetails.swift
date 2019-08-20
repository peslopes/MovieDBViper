//
//  MovieDetails.swift
//  MovieDBViper
//
//  Created by Pedro Enrique Sobrosa Lopes on 16/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import Foundation

// MARK: - MovieDetails
struct MovieDetails: Codable {
    let genres: [Genre]?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case genres, id
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
