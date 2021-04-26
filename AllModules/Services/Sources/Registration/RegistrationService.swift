//
//  RegistrationService.swift
//  Services
//
//  Created by Metalluxx on 18.04.2021.
//

import Foundation
import RxSwift
import NewNetworking

extension Registration {
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

extension Registration.Service: RegistrationServiceProtocol {
    public func sendRegistrationRequest(_ body: Registration.RequestBody) -> Observable<Response> {
        HTTP.Request(
            baseUrl: baseURL,
            path: "/robo/users/userCredentals.php"
        )
        .do {
            $0.method = .post
            $0.body = Body.JSON(body, encoder: encoder)
        }
        .toObservable(
            error: ServiceErrors.invalidUrl
        )
        .debug()
        .flatMap { [loader] in
            loader().load(request: $0)
        }
        .compactMap(\.body)
        .map { [decoder] in
            try decoder.decode(
                StatusResponseDTO<[Registration.ResponseBody]>.self,
                from: $0
            )
        }
        .map(\.data.objects?.first)
        .compactMap { $0.toResult(
            DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [],
                debugDescription: ""
            ))
        )}
    }
}
