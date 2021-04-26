//
//  AnyURL.swift
//  ApplicationCore
//
//  Created by Metalluxx on 14.10.2019.
//  Copyright © 2019 Metallixx. All rights reserved.
//

import Foundation

public enum AnyURL {
    case string(_ value: String)
    case native(_ value: URL)
}

extension AnyURL: RawRepresentable {
    public typealias RawValue = URL?

    public init?(rawValue: URL?) {
        if let url = rawValue {
            self = .native(url)
        } else {
            return nil
        }
    }

    public var rawValue: URL? {
        if case let AnyURL.native(url) = self {
            return url
        }
        return nil
    }
}

extension AnyURL: ExpressibleByStringLiteral {
	public typealias StringLiteralType = String

	public init(stringLiteral value: Self.StringLiteralType) {
		self = .string(value)
	}
}
