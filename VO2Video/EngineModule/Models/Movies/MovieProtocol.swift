//
//  MovieProtocol.swift
//  VO2Video
//
//  Created by Shiny on 15/03/2023.
//

import Foundation

protocol MovieProtocol {
    var posterPath: String? { get }
    func posterImage(of imageSize: ImageSize) -> URL?
}
extension MovieProtocol {
    func constructedURL(imageSize: ImageSize, pathToAppend: String) -> URL? {
        if let url = K.baseImagePath(imageSize: imageSize) {
            return url.appending(path: pathToAppend)
        }
        return nil
    }
    func posterImage(of imageSize: ImageSize) -> URL? {
        guard let posterPath else { return nil }
        return constructedURL(imageSize: imageSize, pathToAppend: posterPath)
    }
}
