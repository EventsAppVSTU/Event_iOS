//
//  HTTP.Request.swift
//  Networking
//
//  Created by Araik Garibian on 12/19/20.
//

import Foundation

public extension HTTP {
	struct Request {
		public var method: HTTPMethod = .get
		public var headers: [String: String] = [:]
		public var body: HTTPBody = Body.Empty()

		public let id = UUID()

		private var urlComponents: URLComponents
		private var options = [ObjectIdentifier: Any]()

		public init() {
			urlComponents = .init()
			urlComponents.scheme = "https"
		}

		public init?(stringUrl: String) {
			if let urlComponents = URLComponents(string: stringUrl) {
				self.urlComponents = urlComponents
			} else {
				return nil
			}
		}

        public init?(
            baseUrl: String,
            path: String,
            params: [String: String]? = nil
        ) {
            guard var urlComponent = URLComponents(string: baseUrl) else { return nil }

            urlComponent.path = path
            urlComponent.queryItems = params?.map { URLQueryItem(name: $0, value: $1) }

            self.urlComponents = urlComponent
        }
	}
}

public extension HTTP.Request {
	subscript<O: HTTPRequestOption>(option type: O.Type) -> O.Value {
		get {
			let id = ObjectIdentifier(type)
			guard let value = options[id] as? O.Value else { return type.defaultOptionValue }
			return value
		}
		set {
			let id = ObjectIdentifier(type)
			options[id] = newValue
		}
	}

	var scheme: URLScheme? {
		get { urlComponents.scheme.flatMap(URLScheme.init) }
		set { urlComponents.scheme = newValue?.rawValue }
	}

	var host: String? {
		get { urlComponents.host }
		set { urlComponents.host = newValue }
	}

	var path: String {
		get { urlComponents.path }
		set { urlComponents.path = newValue }
	}

	var url: URL? {
		urlComponents.url
	}
}
