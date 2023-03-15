//
//  VideoMockedService.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class VideoMockedService: VideoService {
    
    var networkClient: VO2NetworkClient?
    
    required init(networkClient: VO2NetworkClient?) {
        self.networkClient = networkClient
    }
    
}
