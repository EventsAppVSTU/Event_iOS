//
//  HTTP.Response.swift
//  Networking
//
//  Created by Araik Garibian on 12/19/20.
//

import Foundation

public extension HTTP {
	struct Response {
		public let request: HTTP.Request
		private let response: HTTPURLResponse
		public let body: Data?

		public init(
			request: HTTP.Request,
			response: HTTPURLResponse,
			body: Data?
		) {
			self.request = request
			self.response = response
			self.body = body
		}
	}
}

public extension HTTP.Response {
	var message: String {
		HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
	}

	var headers: [AnyHashable: Any] { response.allHeaderFields }
}
