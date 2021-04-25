//
//  UserDataBody.swift
//  Services
//
//  Created by Metalluxx on 26.04.2021.
//

import Foundation
import AppFoundation

public struct UserDataBody: Codable {
    public var name: String
    public var surname: String
    public var image: Data
    public var organizationId: Null<String>
    public var currentEvent: Null<String>
    public var login: String
    public var password: String

    public init(
        name: String,
        surname: String,
        image: Data = .init(),
        organizationId: Null<String> = nil,
        currentEvent: Null<String> = nil,
        login: String,
        password: String
    ) {
        self.name = name
        self.surname = surname
        self.image = image
        self.organizationId = organizationId
        self.currentEvent = currentEvent
        self.login = login
        self.password = password
    }
}
