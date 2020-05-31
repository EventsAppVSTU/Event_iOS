//
//  SettingsViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/31/20.
//

import UIKit
import Library
import Combine
import Views
import Flow

public class SettingsViewModel: BaseViewModel<SettingsFlow> {
	
	typealias Item = Flow.CellItems
	
	@Published var personInfo: Flow.PersonInfo = (avatar: .asset(name: "kremlin"), name: "Araik")
	
	@Published var listItems: [Item] = [
		.divider,
		.item(value:
			SettingsFlow.CellItem(
				icon: .system(name: "square.and.arrow.down"),
				secondaryIcon: .system(name: "multiply.circle.fill"),
				name: "Preferences")
		),
		.divider,
		.emptyPlace,
		.divider,
		.item(value:
			SettingsFlow.CellItem(
				icon: .system(name: "square.and.arrow.down"),
				secondaryIcon: .system(name: "multiply.circle.fill"),
				name: "Person")
		),
		.divider,
		.item(value:
			SettingsFlow.CellItem(
				icon: .system(name: "square.and.arrow.down"),
				secondaryIcon: .system(name: "multiply.circle.fill"),
				name: "Prekol")
		),
		.divider
	]
	
	public override func transform(input: SettingsFlow.Input, bag: inout Set<AnyCancellable>) -> SettingsFlow.Output {
		input.didTap
			.sink {
				print("\(type(of: self)) \($0)")
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
			}
			.store(in: &bag)
		
		return Output(
			personInfo: $personInfo.eraseToAnyPublisher(),
			listData: $listItems.eraseToAnyPublisher()
		)
	}
}
