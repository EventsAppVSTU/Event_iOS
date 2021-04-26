//
//  EventsService.swift
//  Services
//
//  Created by Araik Garibian on 12.01.2021.
//

import Foundation
import AppFoundation
import RxSwift
import NewNetworking

extension Events {
    public class Service {
        private let loader: () -> HTTPLoading
        private let baseURL: String
        private let decoder: JSONDecoder
        private let encoder: JSONEncoder
        private let authorizationStore: AuthorizationStoreProtocol

        public init(
            loader: @escaping () -> HTTPLoading,
            baseURL: String,
            decoder: JSONDecoder = .init(),
            encoder: JSONEncoder = .init(),
            authorizationStore: AuthorizationStoreProtocol
        ) {
            self.loader = loader
            self.baseURL = baseURL
            self.decoder = decoder
            self.encoder = encoder
            self.authorizationStore = authorizationStore
        }
    }
}

extension Events.Service: EventsServiceProtocol {
	public func getEvents() -> Observable<Response> {
        HTTP.Request(
            baseUrl: baseURL,
            path: "/robo/events/eventsInfo.php"
        )
        .do {
            $0.method = .get
            $0.headers["Authorization"] = authorizationStore.getToken()
        }
        .toObservable(error: ServiceErrors.invalidUrl)
        .debug()
        .flatMap { [loader] in loader().load(request: $0) }
        .compactMap(\.body)
        .mapToResult { [decoder] in try decoder.decode(
            StatusResponseDTO<[Events.DTO]>.self,
            from: $0
        )}
        .map {
            $0.flatMap { arr in .success(arr.data.objects ?? []) }
        }
	}
}
