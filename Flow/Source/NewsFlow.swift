//
//  NewsFlow.swift
//  Flow
//
//  Created by Araik Garibian on 6/1/20.
//

import UIKit
import Library
import Combine

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
		public let shareButtonTap: AnyPublisher<Void, Never>
		
		public init(
			shareButtonTap: AnyPublisher<Void, Never>
		) {
			self.shareButtonTap = shareButtonTap
		}
	}
	
	public struct Output {
		public let article: AnyPublisher<Article, Never>
		
		public init(
			article: AnyPublisher<Article, Never>
		) {
			self.article = article
		}
	}
}
