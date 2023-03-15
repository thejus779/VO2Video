//
//  Engine.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import 
import Foundation

class Engine {
        
    private let networkClient: NetworkClient
    
    // Services
    let videoService: VideoService
    
    init(
        mockVideoService: VideoService? = nil,
        mockNetworkClient: VO2NetworkClient? = nil
    ) {
        // Network client
        self.networkClient = mockNetworkClient ?? RMNetworkClient()
        
        // VideoService
        self.videoService = mockVideoService ?? VideoNetworkService(networkClient: networkClient)
    }
}
