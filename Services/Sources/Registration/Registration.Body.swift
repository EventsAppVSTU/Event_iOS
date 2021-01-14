//
//  Registration.Body.swift
//  Services
//
//  Created by Metalluxx on 18.04.2021.
//

import Foundation
import AppFoundation

public extension Registration {
    struct Body: Encodable {
        public var name: String
        public var surname: String
        public var image: Data?
        public var organizationId: Null<String>
        public var organizationVerify: Int
        public var currentEvent: Null<String>
        public var login: String
        public var password: String
        public var phone: String
        public var webLink: String
        public var bio: String

        public init(
            name: String,
            surname: String,
            image: Data = .init(),
            organizationId: Null<String> = .init(),
            organizationVerify: Int,
            currentEvent: Null<String> = .init(),
            login: String,
            password: String,
            phone: String,
            webLink: String,
            bio: String
        ) {
            self.name = name
            self.surname = surname
            self.image = image
            self.organizationId = organizationId
            self.organizationVerify = organizationVerify
            self.currentEvent = currentEvent
            self.login = login
            self.password = password
            self.phone = phone
            self.webLink = webLink
            self.bio = bio
        }
    }
}
