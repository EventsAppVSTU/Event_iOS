//
//  Authorization.ResponseBody.swift
//  Services
//
//  Created by Metalluxx on 26.04.2021.
//

import Foundation
import AppFoundation

public extension Authorization {
    typealias ResponseBody = BodyContainer<UserDataBody, NestedResponseBody>

    struct NestedResponseBody: Decodable {
        public let registrationDate: String
        public let role: IntFromString
        public let id: IntFromString
    }
}

extension Authorization.ResponseBody {
    var token: String {
        "\(optional.id.value) \(required.password)"
    }
}
