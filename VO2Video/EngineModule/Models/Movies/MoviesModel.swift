//
//  Movies.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

struct Movie: Codable {
    let adult: Bool?
    let backgroundImagePath: String?
    let id: Int64
    let overview: String?
    let rating: Double?
    let title: String?
    let releaseDate: Date?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backgroundImagePath = "backdrop_path"
        case overview
        case rating = "vote_average"
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

extension Movie {
    func constructedURL(imageSize: ImageSize, pathToAppend: String) -> URL? {
        if let url = K.baseImagePath(imageSize: imageSize) {
            return url.appending(path: pathToAppend)
        }
        return nil
    }
    func backgroundImageURL(imageSize: ImageSize) -> URL? {
        guard let backgroundImagePath else { return nil }
        return constructedURL(imageSize: imageSize, pathToAppend: backgroundImagePath)
    }
    func posterImageSize(imageSize: ImageSize) -> URL? {
        guard let posterPath else { return nil }
        return constructedURL(imageSize: imageSize, pathToAppend: posterPath)
    }
}
