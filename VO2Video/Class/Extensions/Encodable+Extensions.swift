//
//  Encodable+Extensions.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation

extension Encodable {
    var toJSONDict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return nil }
        return json
    }
}
