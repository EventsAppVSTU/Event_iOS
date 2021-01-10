//
//  HTTP.Result.swift
//  Networking
//
//  Created by Araik Garibian on 12/19/20.
//

public extension HTTP {
	typealias Result = Swift.Result<HTTP.Response, HTTP.Error>
}

public extension HTTP.Result {
	var request: HTTP.Request {
		switch self {
			case .success(let response): return response.request
			case .failure(let error): return error.request
		}
	}

	var response: HTTP.Response? {
		switch self {
			case .success(let response): return response
			case .failure(let error): return error.response
		}
	}
}
