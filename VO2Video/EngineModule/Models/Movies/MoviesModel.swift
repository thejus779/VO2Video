//
//  Movies.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

struct Movie: Codable, MovieProtocol {
    let id: Int
    let overview: String?
    let rating: Double?
    let title: String?
    let releaseDate: Date?
    let posterPath: String?
    
    var isFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case rating = "vote_average"
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
