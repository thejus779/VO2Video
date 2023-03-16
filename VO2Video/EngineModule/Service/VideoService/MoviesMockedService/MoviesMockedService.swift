//
//  MoviesMockedService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class MoviesMockedService: MoviesService {
    var observers: WeakObserverOrderedSet<MoviesServiceObserver>
    
    var networkClient: VO2NetworkClient?
    
    required init(networkClient: VO2NetworkClient?) {
        self.networkClient = networkClient
        observers = WeakObserverOrderedSet<MoviesServiceObserver>()
    }
    
    func getPopularMovies(pageNo: Int, completion: @escaping ResultCallback<VO2Data<Movie>>) {
        
        completion(
            .success(
                VO2Data(
                    currentPage: 1,
                    results: [
                        Movie(id: 1, overview: nil, rating: nil, title: nil, releaseDate: nil, posterPath: nil),
                        Movie(id: 2, overview: nil, rating: nil, title: nil, releaseDate: nil, posterPath: nil),
                        Movie(id: 3, overview: nil, rating: nil, title: nil, releaseDate: nil, posterPath: nil)
                        ],
                    totalPages: 2
                )
            )
        )
    }
    func getDetailsOf(movieId: Int, completion: @escaping ResultCallback<MovieDetails>) {
        completion(
            .success(
                MovieDetails(
                    id: 1, overview: nil, rating: nil, title: nil,
                    releaseDate: nil, posterPath: nil, runtime: nil,
                    revenue: nil
                )
            )
        )
    }
    func updateFavouriteState(movieId: Int, isFavourite: Bool) {}
}
