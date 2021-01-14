//
//  ResponseInt.swift
//  Services
//
//  Created by Metalluxx on 18.04.2021.
//

import AppFoundation

enum ResponseIntErrors: Error {
    case cannotConvertToInt(CodingKey)
    case cannotConvertToIntFromSingleContainer
}

struct IntFromString {
    let value: Int

    init(_ value: Int) {
        self.value = value
    }
}

extension IntFromString: Decodable {
    init(from decoder: Decoder) throws {
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
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode("\(value)")
    }
}
