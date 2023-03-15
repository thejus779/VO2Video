//
//  VO2DataModel.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

struct VO2Data<T: Codable>: Codable {
    let currentPage: Int?
    let results: [T]?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case results
        case totalPages = "total_pages"
    }
}
