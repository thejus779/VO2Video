//
//  VO2EndPoints.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

enum VO2EndPoints: EndpointType {
    case getPopularMovies
    case getMovieDetails(id: Int)
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "\(version)/movie/popular"
        case .getMovieDetails(let movieId):
            return "\(version)/movie/\(movieId)"
        }
    }
    
    var verb: HTTPVerb {
        switch self {
        case .getPopularMovies, .getMovieDetails:
            return .get
        }
    }
    var baseUrl: URL {
        return K.baseAPIPath
    }
    var version: Int {
        switch self {
        default: return 3
        }
    }
}
