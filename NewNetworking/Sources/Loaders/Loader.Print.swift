//
//  Loaders.Print.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/20/20.
//

import Foundation
import OSLog

public extension Loader {
	final class Print: Base {
		public override func load(task: HTTP.Task) {
			os_log(
				"Loading %@ %@",
				log: Self.logStream,
				type: .info,
				task.request.id.uuidString,
				task.request.url?.relativeString ?? "IncorrectURL"
			)

			let callback: HTTP.Callback = {
				os_log(
					"Loaded %@ %@",
					log: Self.logStream,
					type: .info,
					$0.request.id.uuidString,
					task.request.url?.relativeString ?? "IncorrectURL"
				)
			}

			super.load(task: .init(
				request: task.request,
				completionHandlers: task.completionHandlers + [callback]
			))
		}
	}
}

private extension Loader.Print {
	static let logStream = OSLog(
		subsystem: Bundle.main.bundleIdentifier ?? "unknown",
		category: "NewNetworking"
	)
}
