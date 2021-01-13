//
//  GlobalContext.swift
//  Library
//
//  Created by Araik Garibian on 5/30/20.
//

import UIKit
import NewNetworking

public class GlobalContext {
	public let globalNavigationController: UINavigationController
	public let makeLoader: () -> HTTPLoading

	public init(
		globalNavigationController: UINavigationController,
		makeLoader: @escaping () -> HTTPLoading
	) {
		self.globalNavigationController = globalNavigationController
		self.makeLoader = makeLoader
	}
}
