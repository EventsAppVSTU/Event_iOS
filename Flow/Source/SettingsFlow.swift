//
//  SettingsFlow.swift
//  Flow
//
//  Created by Araik Garibian on 5/31/20.
//

import UIKit
import Library
import RxSwift

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
		public let didTap: Observable<Int>
		
		public init(
			didTap: Observable<Int>
		) {
			self.didTap = didTap
		}
	}
	
	public struct Output {
		public let personInfo: Observable<PersonInfo>
		public let listData: Observable<[CellItems]>
		
		public init(
			personInfo: Observable<PersonInfo>,
			listData: Observable<[CellItems]>
		) {
			self.personInfo = personInfo
			self.listData = listData
		}
	}
}
