//
//  VO2EndPoints.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

//enum Result<T> {
//    case success(T)
//    case failure(Error)
//}
//
//typealias ResultCallback<T> = (Result<T>) -> Void
//

enum NetworkResult {
    case success(data: Data?)
    case error(Error)
}

typealias NetworkResultCompletion = (NetworkResult) -> Void

class VO2NetworkClient: NetworkClient {
    
    // MARK: - Work
    @discardableResult
    public func request<T: EndpointType>(
        endpoint: T,
        parameters: [String: Any]?,
        headers: [String: String]? = nil,
        completion: @escaping NetworkResultCompletion
    ) -> URLSessionDataTask? {
        
        var body: Data?
        var queryItems: [URLQueryItem]?
        
        let paramsEncoder = NetworkParamEncoder(
            body: parameters
        )
        
        switch endpoint.verb {
        case .get, .delete:
            queryItems = paramsEncoder.encodeToQueryItems()
        default:
            do {
                body = try paramsEncoder.encodeToData()
            } catch {
                completion(.error(VO2Error.codingError))
            }
        }
        
        let url = endpoint.baseUrl.appendingPathComponent(endpoint.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        
        guard let finalUrl = components?.url else {
            completion(.error(VO2Error.unknown))
            return nil
        }
        
        return request(
            url: finalUrl,
            verb: endpoint.verb,
            httpBody: body,
            headers: headers,
            completion: { (result) in
                switch result {
                case .success(data: let data):
                    completion(.success(data: data))
                case .error(let error):
                    completion(.error(error))
                }
            }
        )
    }
}
class NetworkParamEncoder {
    private let body: [String: Any]?
    
    init(body: [String: Any]?) {
        self.body = body
    }
    
    func encodeToData() throws -> Data? {
        guard let body = body else { return nil }
        return try JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func encodeToQueryItems() -> [URLQueryItem]? {
        guard let body = body else { return nil }
        let params: [URLQueryItem] = body.compactMap({
            var value = String(describing: $1)
            if let arrayValue = $1 as? [Any] {
                value = arrayValue.map({ String(describing: $0) }).joined(separator: ",")
            }
            return URLQueryItem(name: $0, value: value)
        })
        return params.isEmpty ? nil : params
    }
    
}
