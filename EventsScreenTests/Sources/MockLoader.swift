//
//  MockLoader.swift
//  EventsScreenTests
//
//  Created by Araik Garibian on 13.01.2021.
//

import XCTest
import NewNetworking

final class MockLoader {
	var stubbedResult: HTTP.Result?
}

extension MockLoader: HTTPLoading {
	var nextLoader: HTTPLoading? {
		get { nil }
		set {}
	}

	func load(task: HTTP.Task) {
		if let stubbedResult = stubbedResult {
			task.complete(with: stubbedResult)
		} else {
			XCTAssertNil(stubbedResult)
		}
	}
}
