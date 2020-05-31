//
//  SettingsFlow.swift
//  Flow
//
//  Created by Araik Garibian on 5/31/20.
//

import UIKit
import Library
import Combine

public enum SettingsFlow: FlowProtocol {
	
	public typealias PersonInfo = (avatar: Image, name: String)
	
	public enum CellItems: Hashable {
		case divider
		case emptyPlace
		case item(value: CellItem)
	}
	
	public struct CellItem: Hashable {
		public let icon: Image?
		public let secondaryIcon: Image?
		public let name: String
		
		public init(
			icon: Image?,
			secondaryIcon: Image?,
			name: String
		) {
			self.icon = icon
			self.secondaryIcon = secondaryIcon
			self.name = name
		}
	}
	
	public struct Input {
		public let didTap: AnyPublisher<Int, Never>
		
		public init(
			didTap: AnyPublisher<Int, Never>
		) {
			self.didTap = didTap
		}
	}
	
	public struct Output {
		public let personInfo: AnyPublisher<PersonInfo, Never>
		public let listData: AnyPublisher<[CellItems], Never>
		
		public init(
			personInfo: AnyPublisher<PersonInfo, Never>,
			listData: AnyPublisher<[CellItems], Never>
		) {
			self.personInfo = personInfo
			self.listData = listData
		}
	}
}
