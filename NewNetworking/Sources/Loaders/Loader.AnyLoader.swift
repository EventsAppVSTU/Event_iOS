//
//  Loaders.AnyLoader.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/19/20.
//

public extension Loader {
	final class AnyLoader {
		private let loader: HTTPLoading

		public init(_ other: HTTPLoading) {
			self.loader = other
		}
	}
}

public extension HTTPLoading {
	func toAnyLoader() -> Loader.AnyLoader {
		.init(self)
	}
}

extension Loader.AnyLoader: HTTPLoading {
	public func load(task: HTTP.Task) {
		loader.load(task: task)
	}

	public var nextLoader: HTTPLoading? {
		get { loader.nextLoader }
		set { loader.nextLoader = newValue }
	}
}
