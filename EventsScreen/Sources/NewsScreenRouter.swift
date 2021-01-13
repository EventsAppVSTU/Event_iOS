//
//  NewsScreenRouter.swift
//  EventsScreen
//
//  Created by Araik Garibian on 11.01.2021.
//

import NewsScreen
import DesignEngine

public protocol NewsScreenRouterProtocol {
	func showNewsScreen(article: NewsViewModel.Flow.Article)
}

public struct NewsScreenRouter {
	let navigationController: UINavigationController

	public init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension NewsScreenRouter: NewsScreenRouterProtocol {
	public func showNewsScreen(article: NewsViewModel.Flow.Article) {
		let viewModel = NewsViewModel(article: article)
		let viewController = NewsViewController(viewModel: viewModel)
		navigationController.pushViewController(viewController, animated: true)
	}
}
