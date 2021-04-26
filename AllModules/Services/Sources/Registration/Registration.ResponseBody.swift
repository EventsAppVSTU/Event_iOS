//
//  Registration.ResponseBody.swift
//  Services
//
//  Created by Metalluxx on 18.04.2021.
//

import Foundation
import AppFoundation

public extension Registration {
    typealias ResponseBody = BodyContainer<UserDataBody, NestedResponseBody>

    struct NestedResponseBody: Decodable {
        public let phone: String
        public let webLink: String
        public let bio: String
        public let registrationDate: String
        public let role: IntFromString
        public let id: IntFromString
        public let organizationVerify: IntFromString
    }
}

public extension Registration.NestedResponseBody {
    var identifier: Int {
        id.value
    }

    var roleIdentifier: Int {
        role.value
    }

    var organizationVerifyId: Int {
        organizationVerify.value
    }
}

public extension Registration.ResponseBody {
    var token: String {
        "\(optional.identifier) \(required.password)"
    }
}
