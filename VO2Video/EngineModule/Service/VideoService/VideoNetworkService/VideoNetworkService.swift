//
//  VideoNetworkService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class VideoNetworkService: VideoService {
    
    var networkClient: VO2NetworkClient?
    
    required init(networkClient: VO2NetworkClient?) {
        self.networkClient = networkClient
    }
    
}
