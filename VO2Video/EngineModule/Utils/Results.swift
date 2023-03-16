//
//  Results.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

typealias ResultCallback<T> = (Result<T, Error>) -> Void
typealias NetworkResult = Result<Data?, Error>
typealias NetworkResultCompletion = (NetworkResult) -> Void
