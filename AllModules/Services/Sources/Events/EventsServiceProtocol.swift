//
//  EventsServiceProtocol.swift
//  Services
//
//  Created by Araik Garibian on 12.01.2021.
//

import RxSwift

public protocol EventsServiceProtocol {
	func getEvents() -> Observable<Response>
}

public extension EventsServiceProtocol {
    typealias Response = Result<[Events.DTO], Error>
}
