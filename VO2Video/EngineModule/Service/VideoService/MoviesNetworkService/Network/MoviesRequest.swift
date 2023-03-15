//
//  MoviesRequest.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

struct MoviesRequest: Codable {
    let page: Int
    let apiKey: String
    
    enum CodingKeys: String, CodingKey {
        case page
        case apiKey = "api_key"
    }
}
