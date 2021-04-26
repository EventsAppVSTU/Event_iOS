//
//  AuthorizationService.swift
//  Services
//
//  Created by Metalluxx on 26.04.2021.
//

import Foundation
import AppFoundation
import NewNetworking
import RxSwift

extension Authorization {
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

extension Authorization.Service: AuthorizationServiceProtocol {
    public func authorize(
        _ credentials: Authorization.Credentials
    ) -> Observable<Response> {
        HTTP.Request(
            baseUrl: baseURL,
            path: "/robo/users/userCredentals.php",
            params: credentials.toDictionary()
        )
        .do {
            $0.method = .get
        }
        .toObservable(error: ServiceErrors.invalidUrl)
        .debug()
        .flatMap { [loader] in loader().load(request: $0) }
        .compactMap(\.body)
        .map { [decoder] in try decoder.decode(
            StatusResponseDTO<[Authorization.ResponseBody]>.self,
            from: $0
        )}
        .map(\.data.objects?.first)
        .compactMap { $0.toResult(
            DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [],
                debugDescription: ""
            ))
        )}
    }
}

private extension Authorization.Credentials {
    func toDictionary() -> [String: String] {
        [
            "login": login,
            "password": password
        ]
    }
}
