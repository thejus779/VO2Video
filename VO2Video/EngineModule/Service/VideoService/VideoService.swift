//
//  VideoService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

protocol VideoService: AnyObject {
    var networkClient: VO2NetworkClient? { get set }
    /// Initializer
    init(networkClient: VO2NetworkClient?)
}
