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

struct WeakObserverOrderedSet<T> {
    
    struct Weak {
        weak var value: AnyObject?
        init(_ value: AnyObject) {
            self.value = value
        }
    }
    
    var elements: [Weak] = []
    
    private func indexOf(value: AnyObject) -> Int? {
        for (idx, val) in elements.enumerated() where val.value === value {
            return idx
        }
        return nil
    }
    
    @discardableResult
    mutating func add(value: T) -> Bool {
        let anyValue = value as AnyObject
        guard indexOf(value: anyValue) == nil else { return false }
        elements.append(Weak(anyValue))
        return true
    }
    
    mutating func remove(value: T) {
        let anyValue = value as AnyObject
        guard let i = indexOf(value: anyValue) else { return }
        elements.remove(at: i)
    }
    
    func invoke(_ function: ((T) -> Void)) {
        for elem in elements {
            if let eVal = elem.value as? T {
                function(eVal)
            }
        }
    }
}
