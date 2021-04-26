//
//  EventsServiceMock.swift
//  EventsScreenTests
//
//  Created by Araik Garibian on 13.01.2021.
//

import Services
import RxSwift

final class EventsServiceSpy {

	enum Calls {
		case getEvents
	}

	private(set) var calls = [Calls]()
	let stubbedEvents = BehaviorSubject<[Events.DTO]>(value: [])
}

extension EventsServiceSpy: EventsServiceProtocol {
	func getEvents() -> Observable<[Events.DTO]> {
		calls.append(.getEvents)
		return stubbedEvents.asObserver()
	}
}
