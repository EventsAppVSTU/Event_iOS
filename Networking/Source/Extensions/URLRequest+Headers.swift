//
//  URLRequest+Headers.swift
//  ApplicationCore
//
//  Created by Metalluxx on 14.10.2019.
//  Copyright © 2019 Metallixx. All rights reserved.
//

import Foundation

internal extension URLRequest {
    mutating func addHeaders(_ additionalHeaders: [String: String]?) {
        guard let additionalHeaders = additionalHeaders else { return }
        for (key, value) in additionalHeaders {
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
}
