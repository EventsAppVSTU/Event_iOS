//
//  BodyContainer.swift
//  AppFoundation
//
//  Created by Metalluxx on 25.04.2021.
//

import Foundation

public struct BodyContainer<S, O> {
    public var required: S
    public var optional: O

    public init(required: S, optional: O) {
        self.required = required
        self.optional = optional
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<S, T>) -> T {
        required[keyPath: keyPath]
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<O, T>) -> T {
        optional[keyPath: keyPath]
    }
}

extension BodyContainer: Decodable where S: Decodable, O: Decodable {
    public init(from decoder: Decoder) throws {
        required = try S(from: decoder)
        optional = try O(from: decoder)
    }
}

extension BodyContainer: Encodable where S: Encodable, O: Encodable {
    public func encode(to encoder: Encoder) throws {
        try required.encode(to: encoder)
        try optional.encode(to: encoder)
    }
}
