//
//  MoviesMockedService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class MoviesMockedService: MoviesService {
    
    var networkClient: VO2NetworkClient?
    
    required init(networkClient: VO2NetworkClient?) {
        self.networkClient = networkClient
    }
    
    func getPopularMovies(pageNo: Int, completion: @escaping ResultCallback<VO2Data<Movie>>) {
    }
    func getDetailsOf(movieId: Int, completion: @escaping ResultCallback<MovieDetails>) {
        
    }
}
