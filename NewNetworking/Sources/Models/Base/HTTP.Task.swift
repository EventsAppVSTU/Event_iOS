//
//  HTTP.Task.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/22/20.
//

import Foundation

public extension HTTP.Task {
	enum State {
		case prefered
		case running
		case cancelled
		case finished
	}
}

public extension HTTP {
	typealias Callback = (HTTP.Result) -> Void
}

public extension HTTP {
	class Task {
		public var id: UUID { request.id }
		public internal(set) var state: State = .prefered
		public private(set) var cancellationHandlers = Array<() -> Void>()
		public private(set) var completionHandlers: [Callback]
		var request: HTTP.Request

		public init(
			request: HTTP.Request,
			completion: @escaping (HTTP.Result) -> Void
		) {
			self.request = request
			self.completionHandlers = [completion]
		}

		public init(
			request: HTTP.Request,
			completionHandlers: [Callback]
		) {
			self.request = request
			self.completionHandlers = completionHandlers
		}
	}
}

public extension HTTP.Task {
	func addCancellationHandler(_ handler: @escaping () -> Void) {
		cancellationHandlers.append(handler)
	}

	func add(completionHandler: @escaping (HTTP.Result) -> Void) {
		completionHandlers.append(completionHandler)
	}

	func cancel() {
		guard state == .running else { return }

		let handlers = cancellationHandlers
		cancellationHandlers = []
		state = .cancelled

		handlers.reversed().forEach { $0() }
	}

	func complete(with result: HTTP.Result) {
		completionHandlers.reversed().forEach { $0(result) }
	}
}
