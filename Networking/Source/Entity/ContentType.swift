//
//  ContentType.swift
//  ApplicationService
//
//  Created by Metalluxx on 28/09/2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation

public enum ContentType {
    case json
    case form
    case custom(value: String)
}

extension ContentType: RawRepresentable {
    private static var FormType = "application/x-www-form-urlencoded"
    private static var JsonType = "application/json"
    
    public init(rawValue: String) {
        if rawValue == ContentType.JsonType {
            self = .json
        } else if rawValue == ContentType.FormType {
            self = .form
        } else { self = .custom(value: rawValue) }
    }
    
    public var rawValue: String {
        switch self {
        case .form:
            return ContentType.FormType
        case .json:
            return ContentType.JsonType
        case .custom(let value):
            return value
        }
    }
}
