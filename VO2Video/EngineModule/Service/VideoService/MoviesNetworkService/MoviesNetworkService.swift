//
//  MoviesNetworkService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class MoviesNetworkService: MoviesService {
    
    var observers: WeakObserverOrderedSet<MoviesServiceObserver>
    
    var networkClient: VO2NetworkClient?
    
    static let moviesDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-d"
        decoder.dateDecodingStrategy = .formatted(df)
        return decoder
    }()
    
    required init(networkClient: VO2NetworkClient?) {
        self.networkClient = networkClient
        observers = WeakObserverOrderedSet<MoviesServiceObserver>()
    }
    
    func getPopularMovies(pageNo: Int, completion: @escaping ResultCallback<VO2Data<Movie>>) {
        
        let endpoint = VO2EndPoints.getPopularMovies

        // get all popular movies network call
        networkClient?.request(
            endpoint: endpoint,
            parameters: MoviesRequest(page: pageNo, apiKey: endpoint.apiKey).toJSONDict,
            completion: { result in
                switch result {
                case .success(data: let data):
                    if let data = data {
                        do {
                            let popularMovies = try Self.moviesDecoder.decode(VO2Data<Movie>.self, from: data)
                            
                            completion(.success(popularMovies))
                            print("[MoviesNetworkService] getPopularMovies success for page \(pageNo)")
                        } catch let error {
                            completion(.failure(error))
                            print("[MoviesNetworkService] getPopularMovies decoding error: \(error)")
                        }
                    } else {
                        completion(.failure(VO2Error.noData))
                        print("[MoviesNetworkService] getPopularMovies no data")
                    }
                case .error(let error):
                    completion(.failure(error))
                    print("[MoviesNetworkService] getPopularMovies error: \(error)")
                }
            }
        )
    }
    func getDetailsOf(movieId: Int, completion: @escaping ResultCallback<MovieDetails>) {
        let endpoint = VO2EndPoints.getMovieDetails(id: movieId)

        networkClient?.request(
            endpoint: endpoint,
            parameters: MovieDetailsRequest(apiKey: endpoint.apiKey).toJSONDict,
            completion: { result in
                switch result {
                case .success(data: let data):
                    if let data = data {
                        do {
                            let movieDetails = try Self.moviesDecoder.decode(MovieDetails.self, from: data)
                            
                            completion(.success(movieDetails))
                            print("[MoviesNetworkService] getDetailsOf \(movieId) success")
                        } catch let error {
                            completion(.failure(error))
                            print("[MoviesNetworkService] getDetailsOf \(movieId) decoding error: \(error)")
                        }
                    } else {
                        completion(.failure(VO2Error.noData))
                        print("[MoviesNetworkService] getDetailsOf \(movieId) no data")
                    }
                case .error(let error):
                    completion(.failure(error))
                    print("[MoviesNetworkService] getDetailsOf \(movieId) error: \(error)")
                }
            }
        )
    }
    func updateFavouriteState(movieId: Int, isFavourite: Bool) {
        observers.invoke {
            $0.onFavouriteStateUpdated(movieId: movieId, isFavourite: isFavourite)
        }
    }
}
