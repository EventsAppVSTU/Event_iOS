//
//  AnyEndpoint.swift
//  ApplicationCore
//
//  Created by Metalluxx on 14.10.2019.
//  Copyright © 2019 Metallixx. All rights reserved.
//

import Foundation
import Library

public extension URL {
    func request(_ httpMethod: HTTPMethod, path: String...) -> RequestBuilder {
        return RequestBuilder(httpMethod: httpMethod, url: self, path: path)
    }
}


public extension RequestBuilder {
    @discardableResult func set<T>(_ keyPath: WritableKeyPath<RequestBuilder, T>, value: T) -> RequestBuilder {
		var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}


public struct RequestBuilder: RequestStructure {
    // MARK: Required params
    public let httpMethod: HTTPMethod
    public let baseURL: URL
    public let path: [String]
    
    // MARK: Optional params
	public var decoderConfigure: ((JSONDecoder) -> Void)?
    public var body: HTTPBody = .none
    public var urlParams: [String: String?]?
    public var contentType: ContentType = .json
    public var encoderConfigure: ((JSONEncoder) -> Void)?
    public var headers: [String: String]?
    
    // MARK: Inits
    public init(
        httpMethod: HTTPMethod,
        url: URL,
        path: [String])
    {
        self.baseURL = url
        self.path = path
        self.httpMethod = httpMethod
    }
    
    public init?(
        url: AnyURL,
        path: [String],
        httpMethod: HTTPMethod)
    {
        switch url {
        case .native(let url):
            self.init(
                httpMethod: httpMethod,
                url: url,
                path: path
            )
        case .string(let string):
            guard let url = URL(string: string) else { return nil }
            self.init(
                httpMethod: httpMethod,
                url: url,
                path: path
            )
        }
    }
}
