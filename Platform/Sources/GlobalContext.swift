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
    public let decoder: JSONDecoder
    public let encoder:JSONEncoder

	public init(
		globalNavigationController: UINavigationController,
		makeLoader: @escaping () -> HTTPLoading,
        decoder: JSONDecoder,
        encoder:JSONEncoder
	) {
		self.globalNavigationController = globalNavigationController
		self.makeLoader = makeLoader
        self.encoder = encoder
        self.decoder = decoder
	}
}
