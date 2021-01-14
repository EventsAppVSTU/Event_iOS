//
//  Registration.ResponseBody.swift
//  Services
//
//  Created by Metalluxx on 18.04.2021.
//

import Foundation

extension Registration {
    public struct ResponseBody: Decodable {
        public let name: String
        public let surname: String
        public let image: Data?
        public let organizationId: String?
        public let login: String
        public let password: String
        public let phone: String
        public let webLink: String
        public let bio: String
        public let registrationDate: String

        let role: IntFromString?
        let id: IntFromString?
        let organizationVerify: IntFromString?
    }
}

public extension Registration.ResponseBody {
    var identifier: Int? {
        id?.value
    }

    var roleIdentifier: Int? {
        role?.value
    }

    var organizationVerifyId: Int? {
        organizationVerify?.value
    }
}
