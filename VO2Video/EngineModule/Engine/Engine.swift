//
//  Engine.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//
 
import Foundation

class Engine {
        
    private let networkClient: NetworkClient
    
    // Services
    let moviesService: MoviesService
    
    init(
        mockMoviesService: MoviesService? = nil,
        mockNetworkClient: VO2NetworkClient? = nil
    ) {
        // Network client
        let networkClient = mockNetworkClient ?? VO2NetworkClient()
        self.networkClient = networkClient
        
        // VideoService
        self.moviesService = mockMoviesService ?? MoviesNetworkService(networkClient: networkClient)
    }
}
