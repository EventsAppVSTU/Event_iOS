//
//  Registration.Body.swift
//  Services
//
//  Created by Metalluxx on 25.04.2021.
//

import Foundation
import AppFoundation

extension Registration {
    public typealias RequestBody = BodyContainer<UserDataBody, NestedRequestBody>

    public struct NestedRequestBody: Encodable {
        public var phone: String
        public var webLink: String
        public var bio: String
        public var organizationVerify: IntFromString

        public init(
            phone: String,
            webLink: String,
            bio: String,
            organizationVerify: IntFromString
        ) {
            self.phone = phone
            self.webLink = webLink
            self.bio = bio
            self.organizationVerify = organizationVerify
        }
    }
}

public extension Registration.NestedRequestBody {
    var organizationVerifyId: Int {
        organizationVerify.value
    }
}

