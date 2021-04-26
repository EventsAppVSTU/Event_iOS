//
//  AuthorizationStoreProtocol.swift
//  Services
//
//  Created by Metalluxx on 27.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

import Foundation

public protocol AuthorizationStoreProtocol {
    func unauthorize()
    func authorize(token: String)
    func getToken() -> String?
}
