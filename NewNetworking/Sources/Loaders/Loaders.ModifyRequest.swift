//
//  Loaders.ModifyRequest.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/20/20.
//

import Foundation

public extension Loader {
	final class ModifyRequest: Base {
		private let modifier: (inout HTTP.Request) -> Void

		public init(
			modifier: @escaping (inout HTTP.Request) -> Void
		) {
			self.modifier = modifier
			super.init()
		}

		public override func load(task: HTTP.Task) {
			var copyRequest = task.request
			modifier(&copyRequest)
			super.load(task: .init(
				request: copyRequest,
				completionHandlers: task.completionHandlers
			))
		}
	}
}
