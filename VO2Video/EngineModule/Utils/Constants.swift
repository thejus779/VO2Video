//
//  Constants.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

struct K {
    static let baseAPIPath = URL(string: "https://api.themoviedb.org/")!
    
    static func baseImagePath(imageSize: ImageSize) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w\(imageSize.rawValue)")
    }
}
