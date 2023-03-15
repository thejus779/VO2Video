//
//  MoviesNetworkService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class MoviesNetworkService: MoviesService {
    
    var networkClient: VO2NetworkClient?
    
    required init(networkClient: VO2NetworkClient?) {
        self.networkClient = networkClient
    }
    
    func getPopularMovies(pageNo: Int, completion: @escaping ResultCallback<VO2Data<Movies>>) {
        let mov = Movies(adult: nil, backgroundImagePath: nil, id: 1, originalLanguage: nil, overview: nil, rating: nil, title: nil, releaseDate: nil, posterPath: nil)
        let res = VO2Data(currentPage: 1, results: [mov], totalPages: 1)
        completion(.success(res))
    }
}
