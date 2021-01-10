//
//  HTTPLoadingProtocol.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/19/20.
//

public protocol HTTPLoading: AnyObject {
	var nextLoader: HTTPLoading? { get set }

	func load(
		request: HTTP.Request,
		completionHandlers: [(HTTP.Result) -> Void]
	) -> HTTP.Task

	func load(task: HTTP.Task)
}

public extension HTTPLoading {
//	var nextLoader: HTTPLoading? {
//		get { return nil }
//		set { }
//	}

	func load(request: HTTP.Request, completionHandlers: [(HTTP.Result) -> Void]) -> HTTP.Task {
		let task = HTTP.Task(request: request, completionHandlers: completionHandlers)
		load(task: task)
		return task
	}
}
