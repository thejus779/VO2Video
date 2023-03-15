//
//  Movies.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

struct Movies: Codable {
    let adult: Bool?
    let backgroundImagePath: String?
    let id: Int64
    let originalLanguage: Language?
    let overview: String?
    let rating: Double?
    let title: String?
    let releaseDate: Date?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backgroundImagePath = "backdrop_path"
        case originalLanguage = "original_language"
        case overview
        case rating = "vote_average"
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
enum Language: String, Codable {
    case eglish = "en"
    case french = "fr"
    case unknown
}
