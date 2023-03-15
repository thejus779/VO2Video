//
//  VO2Error.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

/// VO2Error with some general error types
enum VO2Error: LocalizedError, Equatable {
    case codingError
    case unknown
    case noData
    case serverError
    
    public var errorDescription: String? {
        switch self {
        case .codingError:
            return "Coding Error"
        case .unknown:
            return "Unknown Error"
        case .noData:
            return "No Data"
        case .serverError:
            return "Server Error"
        }
    }
}
