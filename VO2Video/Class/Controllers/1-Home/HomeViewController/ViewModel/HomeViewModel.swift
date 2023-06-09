//
//  HomeViewModel.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class HomeViewModel {
    
    private let engine: Engine
    
    var allPopularMovies: [Movie]? = []
    var responseData: VO2Data<Movie>?
    var currentPage = 1
    
    init(engine: Engine) {
        self.engine = engine
    }
    func registerObservers(observer: MoviesServiceObserver) {
        engine.moviesService.register(observer: observer)
    }
    
    // Get all popular movies
    func getAllPopularMovies(completion: @escaping ResultCallback<VO2Data<Movie>>)  {
        
        engine.moviesService.getPopularMovies(
            pageNo: currentPage
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.responseData = response
                self?.allPopularMovies = response.results
            default: break
            }
            completion(result)
        }
    }

    func loadMorePopularMoviesIfNeeded(completion: @escaping (Error?) -> Void)  {
        guard currentPage < responseData?.totalPages ?? 0
        else {
            // All data loaded alraedy
            print("All Movies already loaded")
            completion(nil)
            return
        }
        let pageNo = currentPage + 1
        
        engine.moviesService.getPopularMovies(
            pageNo: currentPage
        ) { [weak self] result in
                
            switch result {
            case .success(let newResponse):
                self?.responseData = newResponse
                if let newResults = newResponse.results {
                    self?.allPopularMovies?.append(contentsOf: newResults)
                    
                    // Update page incase of success so that later if the user scrolls more data can be loaded
                    self?.currentPage = pageNo
                    
                    print("Added \(newResults.count) more movies")
                }
                completion(nil)
                
            case .failure(let error):
                print("Failed with error \(error)")
                completion(error)
            }
        }
    }
    
    func getDetailsOf(movie: Movie, completion: @escaping (MovieDetails?, Error?) -> Void) {
        engine.moviesService.getDetailsOf(
            movieId: movie.id
        ) { result in
            switch result {
            case .success(var movieDetails):
                // is favourite is locally handled
                movieDetails.isFavourite = movie.isFavourite
                completion(movieDetails, nil)
            case .failure(let error):
                print("Failed with error \(error)")
                completion(nil, error)
            }
        }
    }
    
    func updateMovieFavouriteState(movieId: Int, isFavourite: Bool) {
        if let index = allPopularMovies?.firstIndex(where: { $0.id == movieId }) {
            allPopularMovies?[index].isFavourite = isFavourite
        }
    }
}
