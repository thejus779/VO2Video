//
//  VO2EndPoints.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

enum VO2EndPoints: EndpointType {
    case getCharacters
    case getLocations
    case getEpisodes
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        case .getLocations:
            return "/location"
        case .getEpisodes:
            return "/episode"
        }
    }
    
    var verb: HTTPVerb {
        switch self {
        case .getCharacters, .getLocations, .getEpisodes:
            return .get
        }
    }
    var baseUrl: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api")
        else { fatalError("Invalid url") }
        return url
    }
}
