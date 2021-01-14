//
//  Unique.swift
//  Library
//
//  Created by Araik Garibian on 5/31/20.
//

import Foundation

public struct Unique<T>: Hashable, Equatable {
	private let uuid = UUID()
	public let value: T

	public init(_ value: T) {
		self.value = value
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(uuid)
	}

	public static func == (lhs: Unique<T>, rhs: Unique<T>) -> Bool {
		return lhs.uuid == rhs.uuid
	}
}

public extension Unique where T: Equatable {
	static func == (lhs: Unique<T>, rhs: Unique<T>) -> Bool {
		return lhs.value == rhs.value
	}
}

public extension Unique where T: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(value)
	}
}
