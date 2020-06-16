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
import Networking

public class EventsListViewModel: BaseViewModel<EventsListFlow> {
	let globalContext: GlobalContext
	
	
	@Lazy public init(globalContext: GlobalContext) {
		self.globalContext = globalContext
		
		super.init()
	}
	
	private(set) lazy var downloadedListData = BehaviorSubject<[EventDTO]>(value: [])
	
	public override func transform(input: Input, bag: DisposeBag) -> Output {
		
		let request = RequestBuilder(url: "http://yaem.online/robo/events/events.php", path: [], httpMethod: .get)!
			.set(\.headers, value: ["Authorization": "1 111111_2"])
		
		Gateway.shared.rx
			.objectRequest(request, objectType: StatusResponseDTO<[EventDTO]>.self)
			.observeOn(
				ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .utility))
			)
			.map {
				switch $0 {
				case .completed(let info):
					return info.arrivalObject.data.objects ?? []
				default: return []
				}
			}
			.subscribe(downloadedListData)
			.disposed(by: bag)
		
		input.descriptionDidTap
			.observeOn(
				ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .utility))
			)
			.map { [unowned self] index in
				try! self.downloadedListData.value()[index]
			}
			.map { (dto) -> NewsFlow.Article in
				NewsFlow.Article(
					title: dto.name,
					description: dto.place,
					content: dto.description,
					image: .remote(url: URL(string: dto.image)!)
				)
			}
			.observeOn(
				MainScheduler.instance
			)
			.subscribe(
				unowned(globalContext) { (arg, instance) in
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
			.observeOn(
				ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .utility))
			)
			.map {
				$0.map {
					(dto) -> Flow.CellItem in
					Flow.CellItem(
						titleText: dto.name,
						descriptionText: dto.description,
						date: dto.startDate,
						image: .remote(url: URL(string: dto.image)!)
					)
				}
			}
		
		return Output(
			listData: uiListData
		)
	}
	
}
