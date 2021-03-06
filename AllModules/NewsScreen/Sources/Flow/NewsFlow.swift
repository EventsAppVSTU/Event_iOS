//
//  NewsFlow.swift
//  Flow
//
//  Created by Araik Garibian on 6/1/20.
//

import DesignEngine
import AppFoundation
import Platform
import RxSwift

public enum NewsFlow: FlowProtocol {
	public struct Article {
		public let title: String
		public let description: String
		public let content: String
		public let image: Image?

		public init(
			title: String,
			description: String,
			content: String,
			image: Image?
		) {
			self.title = title
			self.description = description
			self.content = content
			self.image = image
		}
	}

	public struct Input {
		public let shareButtonTap: Observable<Void>

		public init(
			shareButtonTap: Observable<Void>
		) {
			self.shareButtonTap = shareButtonTap
		}
	}

	public struct Output {
		public let article: Observable<Article>

		public init(
			article: Observable<Article>
		) {
			self.article = article
		}
	}
}
