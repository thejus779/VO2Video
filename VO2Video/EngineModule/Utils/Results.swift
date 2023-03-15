//
//  Results.swift
//  VO2Video
//
//  Created by Shiny on 15/03/2023.
//

import Foundation

typealias ResultCallback<T> = (Result<T, Error>) -> Void

enum NetworkResult {
    case success(data: Data?)
    case error(Error)
}

typealias NetworkResultCompletion = (NetworkResult) -> Void
