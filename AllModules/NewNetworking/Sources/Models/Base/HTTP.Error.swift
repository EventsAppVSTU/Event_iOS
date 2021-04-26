//
//  HTTP.Error.swift
//  Networking
//
//  Created by Araik Garibian on 12/19/20.
//

import Foundation

public extension HTTP {
	struct Error: Swift.Error {
		/// The high-level classification of this error
		public let code: Code

		/// The HTTPRequest that resulted in this error
		public let request: HTTP.Request

		/// Any HTTPResponse (partial or otherwise) that we might have
		public let response: HTTP.Response?

		/// If we have more information about the error that caused this, stash it here
		public let underlyingError: Swift.Error?

		public init(
			code: HTTP.Error.Code,
			request: HTTP.Request,
			response: HTTP.Response? = nil,
			underlyingError: Swift.Error? = nil
		) {
			self.code = code
			self.request = request
			self.response = response
			self.underlyingError = underlyingError
		}
	}
}

public extension HTTP.Error {
	enum Code {
		case invalidEncodeBody(Error)
		case invalidURL
		case invalidRequest     // the HTTPRequest could not be turned into a URLRequest
		case cannotConnect      // some sort of connectivity problem
		case cancelled          // the user cancelled the request
		case insecureConnection // couldn't establish a secure connection to the server
		case invalidResponse    // the system did not receive a valid HTTP response
		case unknown            // we have no idea what the problem is
	}
}
