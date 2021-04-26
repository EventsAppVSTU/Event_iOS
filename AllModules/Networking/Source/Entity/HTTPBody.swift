//
//  AnyParameters.swift
//  ApplicationService
//
//  Created by Metalluxx on 28/09/2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation

public enum HTTPBody {
    case object(value: Encodable)
    case decodableDictionary(value: [String: Any])
    case raw(data: Data)
    case none
}

extension HTTPBody: Encodable {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .object(let value):
            try value.encode(to: encoder)

        case .decodableDictionary(let value):
            try JSONSerialization
                .data(withJSONObject: value, options: .prettyPrinted)
                .encode(to: encoder)

        case .raw(let data):
            try data.encode(to: encoder)

        default:
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
}
