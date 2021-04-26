//
//  AuthorizationServiceProtocol.swift
//  Services
//
//  Created by Metalluxx on 25.04.2021.
//

import RxSwift

public extension Authorization {
    struct Credentials {
        public var login: String
        public var password: String

        public init(
            login: String,
            password: String
        ) {
            self.login = login
            self.password = password
        }
    }
}

public protocol AuthorizationServiceProtocol {
    func authorize(_ credentials: Authorization.Credentials) -> Observable<Response>
}

public extension AuthorizationServiceProtocol {
    typealias Response = Result<Authorization.ResponseBody, Error>
}
