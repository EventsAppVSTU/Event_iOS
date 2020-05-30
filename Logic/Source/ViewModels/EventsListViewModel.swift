//
//  EventsListViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/30/20.
//

import UIKit
import Library
import Combine
import Views
import Flow

public class EventsListViewModel: BaseViewModel<EventsListFlow> {
	let globalContext: GlobalContext
	
	public init(globalContext: GlobalContext) {
		self.globalContext = globalContext
		super.init()
	}
	
	@Published var downloadedListData = [
		EventsListFlow.CellItem(
			titleText: "Кремль и кококкоронавирус",
			descriptionText: "Вчера провели конференцию в сарае с лидерами общественного мнения среди сообщества WAG и обсудили актуальные проблемы общества: кризис малого производства пивных напитков и мехатроников для DSG",
			date: "Вроде вчера это было",
			image: UIImage(named: "kremlin")
		)
	]
	
	public override func transform(input: Library.Empty, bag: inout Set<AnyCancellable>) -> EventsListFlow.Output {
		return Output(listData: $downloadedListData.eraseToAnyPublisher())
	}
	
}