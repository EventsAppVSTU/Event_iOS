//
//  ResponseBundle.swift
//  Networking
//
//  Created by Metalluxx on 21.12.2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Required information
public protocol ResponseInformation {
    var response: URLResponse? { get }
    var request: URLRequest? { get }
}

public protocol ErrorResponseInformation: ResponseInformation {
    var error: Error { get }
}

// MARK: - Response entity
public typealias CompleteResponse<T> = Response<T>.Complete
public typealias ErrorResponse<T> = Response<T>.Error
public typealias ResponseObservable<T> = Observable<Response<T>>

public enum Response<T> {
    case completed(info: Complete)
    case failure(info: Error)
}

extension Response {
    public struct Complete: ResponseInformation {
        public let arrivalObject: T
        public let response: URLResponse?
        public let request: URLRequest?

        public init(_ arrivalObject: T, response: URLResponse? = nil, request: URLRequest? = nil) {
            self.arrivalObject = arrivalObject
            self.response = response
            self.request = request
        }

        public init(_ arrivalObject: T, from bundle: ResponseInformation) {
            self = Complete(arrivalObject, response: bundle.response, request: bundle.request)
        }
    }

    public struct Error: Swift.Error, ErrorResponseInformation {
        public let error: Swift.Error
        public let response: URLResponse?
        public let request: URLRequest?

        public init(_ error: Swift.Error, for: T.Type = T.self, response: URLResponse? = nil, request: URLRequest? = nil) {
            self.error = error
            self.response = response
            self.request = request
        }

        public init(for: T.Type, from bundle: ErrorResponseInformation) {
            self = Error(bundle.error, for: T.self, from: bundle)
        }

        public init(_ error: Swift.Error, for: T.Type, from bundle: ResponseInformation) {
            self = Error(error, for: T.self, response: bundle.response, request: bundle.request)
        }
    }
}
