//
//  NewsViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 6/1/20.
//

import UIKit
import Library
import RxSwift
import Views
import Flow

public class NewsViewModel: BaseViewModel<NewsFlow> {

	public let article: Flow.Article
	public private(set) lazy var articleSubject = BehaviorSubject(value: self.article)

	public init(article: Flow.Article) {
		self.article = article

		super.init()
	}

	public override func transform(input: Input, bag: DisposeBag) -> Output {
		return Output(
			article: articleSubject.asObserver()
		)
	}
}
