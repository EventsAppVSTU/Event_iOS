//
//  AuthorizationStore.swift
//  Services
//
//  Created by Metalluxx on 27.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

import Foundation

public extension Authorization {
    final class Store {
        private static let defaultKey = "ahahahah-nice-token"

        private let userDefaults: UserDefaults
        private let key: String

        public init(
            userDefaults: UserDefaults
        ) {
            self.userDefaults = userDefaults
            self.key = Self.defaultKey
        }

        public init(
            userDefaults: UserDefaults,
            key: String
        ) {
            self.userDefaults = userDefaults
            self.key = key
        }
    }
}

extension Authorization.Store: AuthorizationStoreProtocol {
    public func authorize(token: String) {
        userDefaults.set(
            token.data(using: .utf8)?.base64EncodedString(),
            forKey: key
        )
    }

    public func unauthorize() {
        userDefaults.setNilValueForKey(key)
    }

    public func getToken() -> String? {
        userDefaults.string(forKey: key)
            .flatMap { Data(base64Encoded: $0) }
            .flatMap { String(data: $0, encoding: .utf8) }
    }
}
