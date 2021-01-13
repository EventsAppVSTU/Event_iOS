//
//  EventsListViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/30/20.
//

import DesignEngine
import Library
import RxSwift
import Platform
import NewsScreen
import Services

public class EventsListViewModel: BaseViewModel<EventsListFlow> {
	let router: NewsScreenRouterProtocol
	let service: EventsServiceProtocol

	public init(
		router: NewsScreenRouterProtocol,
		service: EventsServiceProtocol
	) {
		self.router = router
		self.service = service

		super.init()
	}

	private(set) var downloadedListData = BehaviorSubject<[Events.DTO]>(value: [])

	public override func transform(input: Input, bag: DisposeBag) -> Output {
		input.descriptionDidTap
			.observe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .utility)))
			.compactMap { [unowned self] index in
				try? self.downloadedListData.value()[index]
			}
			.map(NewsFlow.Article.init)
			.subscribe { [router] instance in
				guard case .next(let info) = instance else { return }
				router.showNewsScreen(article: info)
			}
			.disposed(by: bag)

		input.descriptionDidTap
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { _ in
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
			})
			.disposed(by: bag)

		let firstLoader = service.getEvents()

		let otherLoaders = input.pullToRefresh
			.flatMap(service.getEvents)
			.share()

		Observable.merge([firstLoader, otherLoaders])
			.subscribe(downloadedListData)
			.disposed(by: bag)

		let uiData = downloadedListData
			.map { $0.map(EventsListFlow.CellItem.init) }

		return Output(
			listData: uiData.share(),
			downloadedData: otherLoaders.map { _ in () } .share()
		)
	}
}

private extension EventsListFlow.CellItem {
	init(dto: Events.DTO) {
		self.init(
			titleText: dto.name,
			descriptionText: dto.description,
			date: dto.startDate,
			image: .remote(url: URL(string: dto.image)!)
		)
	}
}

private extension NewsFlow.Article {
	init(dto: Events.DTO) {
		self.init(
			title: dto.name,
			description: dto.place,
			content: dto.description,
			image: .remote(url: URL(string: dto.image)!)
		)
	}
}
