//
//  Null.swift
//  AppFoundation
//
//  Created by Metalluxx on 21.04.2021.
//

import Foundation

public struct Null<T> {
    public let value: T?

    public init(_ value: T? = nil) {
        self.value = value
    }
}

extension Null: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self.value = nil
    }
}

extension Null: Encodable where T: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        if let value = value {
            try container.encode(value)
        } else {
            try container.encodeNil()
        }
    }
}

extension Null: Decodable where T: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            value = nil
        } else if let value = try? container.decode(T.self) {
            self.value = value
        } else {
            throw DecodingError.typeMismatch(
                Self.self,
                DecodingError.Context(codingPath: [], debugDescription: "Don't match decoding cases for \(Self.self)"))
        }

    }
}
