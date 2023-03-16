//
//  NetworkClient.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

class NetworkClient {
    
    static let defaultSessionConfiguration = URLSessionConfiguration.default
    let session = URLSession(configuration: NetworkClient.defaultSessionConfiguration)
    
    @discardableResult
    public func request(
        url: URL,
        verb: HTTPVerb,
        httpBody: Data?,
        headers: [String: String]?,
        completion: @escaping NetworkResultCompletion
    ) -> URLSessionDataTask? {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = verb.rawValue
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = headers

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            self.handle(
                response: response,
                data: data,
                error: error,
                completion: completion
            )
        }
        task.resume()
        return task
    }
    
    
    private func handle(
        response: URLResponse?,
        data: Data?,
        error: Error?,
        completion: @escaping NetworkResultCompletion
    ) {
        if let error {
            guard (error as NSError).code != NSURLErrorCancelled else {
                // the request was cancelled by the user, forget about it
                return
            }
            forwardResult(.failure(error), completion: completion)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            forwardResult(.failure(VO2Error.unknown), completion: completion)
            return
        }
        guard httpResponse.statusCode >= 200  else {
            forwardResult(.failure(VO2Error.serverError), completion: completion)
            return
        }
        var dataResult: Data?
        if let data, !data.isEmpty {
            dataResult = data
        } else {
            forwardResult(.failure(VO2Error.noData), completion: completion)
        }
        
        forwardResult(.success(dataResult), completion: completion)
    }
    
    // MARK: - Thread Helper to forward the result
    private func forwardResult(_ result: NetworkResult, completion: @escaping NetworkResultCompletion) {
        guard Thread.current != Thread.main else {
            // Already on main thread forward
            completion(result)
            return
        }
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
