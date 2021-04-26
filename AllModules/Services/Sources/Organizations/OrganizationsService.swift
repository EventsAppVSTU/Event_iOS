//
//  OrganizationsService.swift
//  Services
//
//  Created by Metalluxx on 27.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

import Foundation
import AppFoundation
import NewNetworking
import RxSwift

extension Organizations {
    public class Service {
        private let loader: () -> HTTPLoading
        private let baseURL: String
        private let decoder: JSONDecoder
        private let encoder: JSONEncoder

        public init(
            loader: @escaping () -> HTTPLoading,
            baseURL: String,
            decoder: JSONDecoder = .init(),
            encoder: JSONEncoder = .init()
        ) {
            self.loader = loader
            self.baseURL = baseURL
            self.decoder = decoder
            self.encoder = encoder
        }
    }
}

extension Organizations.Service: OrganizationsServiceProtocol {
    public func getOrganizations() -> Observable<Response> {
        HTTP.Request(
            baseUrl: baseURL,
            path: "/robo/events/organizations.php"
        )
        .do { $0.method = .get }
        .toObservable(error: ServiceErrors.invalidUrl)
        .flatMap { [loader] req in loader().load(request: req) }
        .compactMap(\.body)
        .map { [decoder] in try decoder.decode(
            StatusResponseDTO<[RawResponse]>.self,
            from: $0
        )}
        .map(\.data.objects)
        .compactMap { $0.toResult(
            DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [],
                debugDescription: ""
            ))
        )}
        .map {
            $0.flatMap { arr in .success(arr.map(\.description)) }
        }
    }
}

private extension Organizations.Service {
    struct RawResponse: Decodable {
        let id: IntFromString
        let name: String
    }
}

private extension Organizations.Service.RawResponse {
    var description: Organizations.Description {
        Organizations.Description(id: id.value, name: name)
    }
}
