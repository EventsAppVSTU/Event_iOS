//
//  Loaders.Base.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/19/20.
//

public extension Loader {
	class Base: HTTPLoading {
		open var nextLoader: HTTPLoading? {
			willSet {
				guard nextLoader == nil else {
					fatalError("The nextLoader may only be set once")
				}
			}
		}

		open func load(task: HTTP.Task) {
			if let next = nextLoader {
				next.load(task: task)
			} else {
				task.complete(with: .failure(
					.init(code: .cannotConnect, request: task.request)
				))
			}
		}

		public init() { }
	}
}
