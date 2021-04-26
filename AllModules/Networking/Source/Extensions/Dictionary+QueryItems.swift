//
//  Dictionary+QueryItems.swift
//  ApplicationService
//
//  Created by Metalluxx on 28/09/2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation

internal extension Dictionary where Key == String, Value == String? {
    var queryItems: [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        for item in self {
            queryItems.append(
                URLQueryItem(name: item.key, value: item.value)
            )
        }
        return queryItems
    }
}
