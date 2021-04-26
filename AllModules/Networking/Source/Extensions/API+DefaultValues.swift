//
//  API+RawRepres.swift
//  ApplicationService
//
//  Created by Metalluxx on 28/09/2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation

public extension RequestStructure where Self: RawRepresentable, Self.RawValue == String {
    var path: String {
        return self.rawValue
    }
}

public extension RequestStructure {
    var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy {
        return .useDefaultKeys
    }

    var urlParams: [String: String?]? {
        return nil
    }

    var contentType: ContentType {
        return .json
    }

    static var sharedHeaders: [String: String]? {
        return nil
    }

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        return .useDefaultKeys
    }
}
