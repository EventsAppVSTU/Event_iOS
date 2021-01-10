//
//  Body.Data.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/19/20.
//

import Foundation

public extension Body {
	struct Data {
		public var additionalHeaders: [String: String]
		let data: Foundation.Data

		public init(
			_ data: Foundation.Data,
			additionalHeaders: [String: String] = [:]
		) {
			self.data = data
			self.additionalHeaders = additionalHeaders
		}
	}
}

extension Body.Data: HTTPBody {
	public func encode() throws -> Data {
		data
	}

	public var isEmpty: Bool {
		data.isEmpty
	}
}
