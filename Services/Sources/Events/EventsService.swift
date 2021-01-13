//
//  EventsService.swift
//  Services
//
//  Created by Araik Garibian on 12.01.2021.
//

import Foundation
import RxSwift
import NewNetworking

public class EventsService {
	let loader: () -> HTTPLoading

	public init(loader: @escaping () -> HTTPLoading) {
		self.loader = loader
	}
}

extension EventsService: EventsServiceProtocol {
	public func getEvents() -> Observable<[Events.DTO]> {
		if let request = HTTP.Request(stringUrl: "http://yaem.online/robo/events/events.php") {
			return loader()
				.load(request: request)
				.compactMap(\.body)
				.map { try? JSONDecoder().decode(StatusResponseDTO<[Events.DTO]>.self, from: $0) }
				.compactMap { $0 }
				.compactMap(\.data.objects)
		} else {
			return .create(withError: ServiceErrors.invalidUrl)
		}
	}
}
