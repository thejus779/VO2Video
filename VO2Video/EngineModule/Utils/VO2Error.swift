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
            return R.string.localizable.commonErrorCoding()
        case .unknown:
            return R.string.localizable.commonErrorUnknown()
        case .noData:
            return R.string.localizable.commonErrorNoData()
        case .serverError:
            return R.string.localizable.commonErrorServerError()
        }
    }
}
