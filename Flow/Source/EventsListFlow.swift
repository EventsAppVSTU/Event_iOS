//
//  EventsListFlow.swift
//  Flow
//
//  Created by Araik Garibian on 5/30/20.
//

import UIKit
import Library
import Combine

public enum EventsListFlow: FlowProtocol {
	
	public struct CellItem: Hashable {
		public let titleText: String
		public let descriptionText: String
		public let date: String
		public let image: UIImage?
		
		public init(
			titleText: String,
			descriptionText: String,
			date: String,
			image: UIImage?
		) {
			self.titleText = titleText
			self.descriptionText = descriptionText
			self.date = date
			self.image = image
		}
	}
	
	public struct Input {
		public let descriptionDidTap: AnyPublisher<Int, Never>
		
		public init(
			descriptionDidTap: AnyPublisher<Int, Never>
		) {
			self.descriptionDidTap = descriptionDidTap
		}
	}
	
	public struct Output {
		public let listData: AnyPublisher<[CellItem], Never>
		
		public init(
			listData: AnyPublisher<[CellItem], Never>
		) {
			self.listData = listData
		}
	}
}
