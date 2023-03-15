//
//  EndpointType.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//


import Foundation

/* Confirm all end points to EndpointType */
protocol EndpointType {
    var path: String { get }
    var verb: HTTPVerb { get }
    var baseUrl: URL { get }
    var apiKey: String { get }
}

// MARK: - Http verbs
enum HTTPVerb: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
extension EndpointType {
    var apiKey: String {
        return "b1e1b6616ed2694dde8715fb2566a7e6"
    }
}
