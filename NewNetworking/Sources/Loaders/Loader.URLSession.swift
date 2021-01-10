//
//  Loader.URLSession.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/19/20.
//

import Foundation

public extension Loader {
	final class URLSession {
		public var nextLoader: HTTPLoading?
		private let session: Foundation.URLSession

		public init(session: Foundation.URLSession = .shared) {
			self.session = session
		}
	}
}

extension Loader.URLSession: HTTPLoading {
	public func load(task: HTTP.Task) {
		guard let url = task.request.url else {
			task.finishedTask(with: .failure(
				.init(code: .invalidURL, request: task.request)
			))
			return
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = task.request.method.rawValue

		for (header, value) in task.request.headers {
			urlRequest.addValue(value, forHTTPHeaderField: header)
		}

		if task.request.body.isEmpty == false {
			for (header, value) in task.request.body.additionalHeaders {
				urlRequest.addValue(value, forHTTPHeaderField: header)
			}

			do {
				urlRequest.httpBody = try task.request.body.encode()
			}
			catch let e {
				task.finishedTask(with: .failure(
					.init(code: .invalidEncodeBody(e), request: task.request)
				))
				return
			}
		}

		let dataTask = session.dataTask(
			with: urlRequest,
			completionHandler: makeCompleteHandlerClosure(task: task)
		)

		task.state = .running

		task.addCancellationHandler {
			dataTask.cancel()
		}

		dataTask.resume()
	}
}

private extension Loader.URLSession {
	func makeCompleteHandlerClosure(
		task: HTTP.Task
	) -> (Data?, URLResponse?, Error?) -> Void {
		{ [weak self] (data, response, error) in
			let result: HTTP.Result
			var httpResponse: HTTP.Response?

			if let httpNativeResponse = response as? HTTPURLResponse {
				httpResponse = HTTP.Response(
					request: task.request,
					response: httpNativeResponse,
					body: data
				)
			}

			if let e = error as? URLError {
				let code: HTTP.Error.Code
				switch e.code {
					case .badURL: code = .invalidURL
					default: code = .unknown
				}
				result = .failure(HTTP.Error(
					code: code,
					request: task.request,
					response: httpResponse,
					underlyingError: e
				))
			} else if let someError = error {
				result = .failure(HTTP.Error(
					code: .unknown,
					request: task.request,
					response: httpResponse,
					underlyingError: someError
				))
			} else if let r = httpResponse {
				result = .success(r)
			} else {
				result = .failure(HTTP.Error(
					code: .invalidResponse,
					request: task.request,
					response: httpResponse,
					underlyingError: error
				))
			}

			task.complete(with: result)
			task.state = .finished

			self?.nextLoader?.load(task: task)
		}
	}
}

private extension HTTP.Task {
	func finishedTask(with result: HTTP.Result) {
		state = .finished
		complete(with: result)
	}
}
