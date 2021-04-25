//
//  IntFromString.swift
//  AppFoundation
//
//  Created by Metalluxx on 25.04.2021.
//

import Foundation

public enum ResponseIntErrors: Error {
    case cannotConvertToInt(CodingKey)
    case cannotConvertToIntFromSingleContainer
}

public struct IntFromString {
    public let value: Int

    public init(_ value: Int) {
        self.value = value
    }
}

extension IntFromString: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: Int) {
        self.value = value
    }
}

extension IntFromString: Decodable {
    public init(from decoder: Decoder) throws {
        let stringValue = try decoder.singleValueContainer().decode(String.self)

        self.value = try Int(stringValue)
            .or(
                DecodingError.typeMismatch(
                    Self.self,
                    DecodingError.Context(codingPath: [], debugDescription: "CannotConvertToIntFromSingleContainer")
                )
            )
    }
}

extension IntFromString: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode("\(value)")
    }
}
