//
//  HTTPBody.swift
//  Networking
//
//  Created by Araik Garibian on 12/19/20.
//

import Foundation

public protocol HTTPBody {
	var isEmpty: Bool { get }
	var additionalHeaders: [String: String] { get }

	func encode() throws -> Data
}

public extension HTTPBody {
	var isEmpty: Bool { return false }
	var additionalHeaders: [String: String] { return [:] }
}
