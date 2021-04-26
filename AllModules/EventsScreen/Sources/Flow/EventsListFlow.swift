//
//  EventsListFlow.swift
//  Flow
//
//  Created by Araik Garibian on 5/30/20.
//

import DesignEngine
import Platform
import RxSwift

public enum EventsListFlow: FlowProtocol {

	public struct CellItem: Hashable {
		public let titleText: String
		public let descriptionText: String
		public let date: String
		public let image: Image?

		public init(
			titleText: String,
			descriptionText: String,
			date: String,
			image: Image?
		) {
			self.titleText = titleText
			self.descriptionText = descriptionText
			self.date = date
			self.image = image
		}
	}

	public struct Input {
		public let descriptionDidTap: Observable<Int>
		public let pullToRefresh: Observable<Void>

		public init(
			descriptionDidTap: Observable<Int>,
			pullToRefresh: Observable<Void>
		) {
			self.descriptionDidTap = descriptionDidTap
			self.pullToRefresh = pullToRefresh
		}
	}

	public struct Output {
		public let listData: Observable<[CellItem]>
		public let downloadedData: Observable<Void>

		public init(
			listData: Observable<[CellItem]>,
			downloadedData: Observable<Void>
		) {
			self.listData = listData
			self.downloadedData = downloadedData
		}
	}
}
