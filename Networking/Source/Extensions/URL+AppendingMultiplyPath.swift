//
//  URL+AppendingMultiplyPath.swift
//  Networking
//
//  Created by Metalluxx on 15.12.2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation

internal extension URL {
    func appendingPathComponent(_ pathArray: [String]) -> URL {
        return pathArray.reduce(self) {
			res, pathItem -> URL in
            res.appendingPathComponent(pathItem)
        }
    }
}
