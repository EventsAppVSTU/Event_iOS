//
//  EventsListViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/30/20.
//

import UIKit
import Library
import RxSwift
import Views
import Flow
import NewNetworking
import ObjectiveC.runtime

public class EventsListViewModel: BaseViewModel<EventsListFlow> {
	let globalContext: GlobalContext

	public init(globalContext: GlobalContext) {
		self.globalContext = globalContext

		super.init()
	}

	private(set) var downloadedListData = BehaviorSubject<[EventDTO]>(value: [])

	public override func transform(input: Input, bag: DisposeBag) -> Output {
		input.descriptionDidTap
			.observe(on:
				ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .utility))
			)
			.compactMap { [unowned self] index in
				try? self.downloadedListData.value()[index]
			}
			.map { dto -> NewsFlow.Article in
				NewsFlow.Article(
					title: dto.name,
					description: dto.place,
					content: dto.description,
					image: .remote(url: URL(string: dto.image)!)
				)
			}
			.observe(on:
				MainScheduler.instance
			)
			.subscribe(
				unowned(globalContext) { arg, instance in
					switch instance {
					case.next(let info):
						UIImpactFeedbackGenerator(style: .light).impactOccurred()
						arg.globalNavigationController.pushViewController(ScreenBuilder.getNewsScreen(article: info), animated: true)
					default: break
					}
				}
			)
			.disposed(by: bag)

		let uiListData = downloadedListData
			.observe(on:
				ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .utility))
			)
			.map { $0.map(Flow.CellItem.init) }

		if let request = HTTP.Request(stringUrl: "http://yaem.online/robo/events/events.php") {
			makeChains {
				Loader.ModifyRequest { $0.headers["Authorization"] = "1 111111_2" }
				Loader.Print()
				Loader.URLSession()
			}
			.load(request: request)
				.compactMap(\.response?.body)
				.map { try? JSONDecoder().decode(StatusResponseDTO<[EventDTO]>.self, from: $0) }
				.compactMap { $0 }
				.compactMap(\.data.objects)
				.subscribe(downloadedListData)
				.disposed(by: bag)
		}

		return Output(
			listData: uiListData
		)
	}
}

private extension EventsListFlow.CellItem {
	init(dto: EventDTO) {
		self.init(
			titleText: dto.name,
			descriptionText: dto.description,
			date: dto.startDate,
			image: .remote(url: URL(string: dto.image)!)
		)
	}
}
