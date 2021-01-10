//
//  Body.Empty.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/19/20.
//

import Foundation

public extension Body {
	struct Empty {
		public init() { }
	}
}

extension Body.Empty: HTTPBody {
	public var isEmpty: Bool {
		true
	}

	public func encode() throws -> Data { Data() }
}
