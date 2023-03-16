//
//  MoviesService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation
protocol MoviesServiceObserver {
    func onFavouriteStateUpdated(movieId: Int, isFavourite: Bool)
}

protocol MoviesService: AnyObject {
    var networkClient: VO2NetworkClient? { get set }
    var observers: WeakObserverOrderedSet<MoviesServiceObserver> { get set }
    /// Initializer
    init(networkClient: VO2NetworkClient?)
    
    /// get all movies with pagination handling
    func getPopularMovies(pageNo: Int, completion: @escaping ResultCallback<VO2Data<Movie>>)
    
    /// get movie details matching id
    func getDetailsOf(movieId: Int, completion: @escaping ResultCallback<MovieDetails>)
    
    /// Updating favourite state
    func updateFavouriteState(movieId: Int, isFavourite: Bool)
}

extension MoviesService {
    public func register(observer: MoviesServiceObserver) {
        assert(Thread.isMainThread, "[MoviesService] register observer from background thread")
        observers.add(value: observer)
    }
    public func unregister(observer: MoviesServiceObserver) {
        assert(Thread.isMainThread, "[MoviesService] unregister observer from background thread")
        observers.remove(value: observer)
    }
}
