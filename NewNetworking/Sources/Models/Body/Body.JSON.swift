//
//  Body.JSON.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/19/20.
//

import Foundation

public extension Body {
	struct JSON {
		public var additionalHeaders = [
			"Content-Type": "application/json; charset=utf-8"
		]

		private let encodeClosure: () throws -> Foundation.Data

		public init<T: Encodable>(
			_ value: T,
			encoder: JSONEncoder = JSONEncoder()
		) {
			self.encodeClosure = { try encoder.encode(value) }
		}
	}
}

extension Body.JSON: HTTPBody {
	public func encode() throws -> Foundation.Data {
		return try encodeClosure()
	}
}
