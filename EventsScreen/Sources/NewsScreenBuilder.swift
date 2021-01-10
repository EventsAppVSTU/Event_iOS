//
//  NewsScreenBuilder.swift
//  EventsScreen
//
//  Created by Araik Garibian on 11.01.2021.
//

import NewsScreen
import DesignEngine

func getNewsScreen(article: NewsViewModel.Flow.Article) -> UIViewController {
	let viewModel = NewsViewModel(article: article)
	return NewsViewController(viewModel: viewModel)
}
