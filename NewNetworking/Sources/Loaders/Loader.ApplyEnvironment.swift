// swiftlint:disable all

////
////  Loader.Environment.swift
////  NewNetworking
////
////  Created by Araik Garibian on 12/20/20.
////
//
//import Foundation
//
//public extension Loader {
//	final class Environment: Base {
//		private let localEnvironment: Config
//
//		internal init(localEnvironment: Loader.Environment.Config) {
//			self.localEnvironment = localEnvironment
//			super.init()
//		}
//
////		public override func load(task: HTTP.Task) {
////			var copy = task.request
////
////			let env = task.request.environment ?? localEnvironment
////
////			if copy.host?.isEmpty ?? false {
////				copy.host = env.host
////			}
////
////			if copy.path.hasPrefix("/") == false {
////				// TODO: apply the environment.pathPrefix
////			}
////
////			for (header, value) in env.headers {
////				copy.headers[header] = value
////			}
////
////			super.load(task: .init(
////				request: copy,
////				completion: task.completion
////			))
////		}
//	}
//}
//
//extension Loader.Environment.Config: HTTPRequestOption {
//	public static var defaultOptionValue: Self? {
//		nil
//	}
//}
//
//public extension HTTP.Request {
//	var environment: Loader.Environment.Config? {
//		get { self[option: Loader.Environment.Config.self] }
//		set { self[option: Loader.Environment.Config.self] = newValue }
//	}
//}
//
//public extension Loader.Environment {
//	struct Config {
//		public var host: String
//		public var pathPrefix: String
//		public var headers: [String: String]
//		public var query: [URLQueryItem]
//
//		public init(
//			host: String,
//			pathPrefix: String = "/",
//			headers: [String: String] = [:],
//			query: [URLQueryItem] = []
//		) {
//			// make sure the pathPrefix starts with a /
//			let prefix = pathPrefix.hasPrefix("/") ? "" : "/"
//
//			self.host = host
//			self.pathPrefix = prefix + pathPrefix
//			self.headers = headers
//			self.query = query
//		}
//	}
//}
