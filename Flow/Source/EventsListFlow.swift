//
//  EventsListFlow.swift
//  Flow
//
//  Created by Araik Garibian on 5/30/20.
//

import UIKit
import Library
import RxSwift

public enum EventsListFlow: FlowProtocol {
	
	public struct CellItem: Hashable {
		public let titleText: String
		public let descriptionText: String
		public let date: String
		public let image: Image
		
		public init(
			titleText: String,
			descriptionText: String,
			date: String,
			image: Image
		) {
			self.titleText = titleText
			self.descriptionText = descriptionText
			self.date = date
			self.image = image
		}
	}
	
	
	public struct Input {
		public let descriptionDidTap: Observable<Int>
		
		public init(
			descriptionDidTap: Observable<Int>
		) {
			self.descriptionDidTap = descriptionDidTap
		}
	}
	
	public struct Output {
		public let listData: Observable<[CellItem]>
		
		public init(
			listData: Observable<[CellItem]>
		) {
			self.listData = listData
		}
	}
}
