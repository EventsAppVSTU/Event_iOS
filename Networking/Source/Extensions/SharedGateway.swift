//
//  SharedGateway.swift
//  ApplicationCore
//
//  Created by Араик Гарибян on 18/10/2019.
//  Copyright © 2019 Metallixx. All rights reserved.
//

import Foundation

private let _gateway = Gateway()

public extension Gateway {
    static var shared: Gateway {
        return _gateway as Gateway
    }
}
