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
        
        let endpoint = VO2EndPoints.getPopularMovies
        // 1. Set pageNo as paramters
        var parameters: [String : Any] = ["page": pageNo]
        parameters["api_key"] = endpoint.apiKey
        
        // TODO: parameter
        
        
        // get all popular movies network call
        networkClient?.request(
            endpoint: VO2EndPoints.getPopularMovies,
            parameters: parameters,
            completion: { result in
                switch result {
                case .success(data: let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let df = DateFormatter()
                            df.dateFormat = "yyyy-MM-d"
                            decoder.dateDecodingStrategy = .formatted(df)
                            
                            let popularMovies = try decoder.decode(VO2Data<Movies>.self, from: data)
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
}
