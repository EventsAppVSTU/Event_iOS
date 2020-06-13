//
//  SettingsViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/31/20.
//

import UIKit
import Library
import RxSwift
import Views
import Flow

public class SettingsViewModel: BaseViewModel<SettingsFlow> {
	
	typealias Item = Flow.CellItems
	
	let personInfo = BehaviorSubject<Flow.PersonInfo>(
		value: (avatar: .asset(name: "kremlin"), name: "Araik")
	)
	
	let listItems = BehaviorSubject<[Item]>(
		value: [
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
	)
	
	public override func transform(input: SettingsFlow.Input, bag: DisposeBag) -> SettingsFlow.Output {
		input.didTap
			.observeOn(
				ConcurrentDispatchQueueScheduler(qos: .utility)
			)
			.subscribe(onNext: {
				print("\(type(of: self)) \($0) ")
				print(Thread.current)
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
			})
			.disposed(by: bag)

		
		return Output(
			personInfo: personInfo.asObserver(),
			listData: listItems.asObserver()
		)
	}
}
