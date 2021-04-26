//
//  NewsScreenRouterSpy.swift
//  EventsScreenTests
//
//  Created by Araik Garibian on 13.01.2021.
//

@testable import EventsScreen
import NewsScreen

final class NewsScreenRouterSpy {
	enum Calls {
		case showNewsScreen(article: NewsViewModel.Flow.Article)
	}

	private(set) var calls = [Calls]()
}

extension NewsScreenRouterSpy: NewsScreenRouterProtocol {
	func showNewsScreen(article: NewsViewModel.Flow.Article) {
		calls.append(.showNewsScreen(article: article))
	}
}
