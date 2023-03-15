//
//  VO2EndPoints.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

enum VO2EndPoints: EndpointType {
    case getPopularMovies
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "\(version)/movie/popular"
        }
    }
    
    var verb: HTTPVerb {
        switch self {
        case .getPopularMovies:
            return .get
        }
    }
    var baseUrl: URL {
        guard let url = URL(string: "https://api.themoviedb.org/")
        else { fatalError("Invalid url") }
        return url
    }
    var version: Int {
        switch self {
        default: return 3
        }
    }
}
