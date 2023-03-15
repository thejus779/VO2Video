//
//  MoviesService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

protocol MoviesService: AnyObject {
    var networkClient: VO2NetworkClient? { get set }
    /// Initializer
    init(networkClient: VO2NetworkClient?)
    
    /// get all movies with pagination handling
    func getPopularMovies(pageNo: Int, completion: @escaping ResultCallback<VO2Data<Movie>>)
    
    /// get movie details matching id
    func getDetailsOf(movieId: Int, completion: @escaping ResultCallback<MovieDetails>)
}
