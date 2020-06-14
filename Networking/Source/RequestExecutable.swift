//
//  DefaultGateway+IRouter.swift
//  ApplicationService
//
//  Created by Metalluxx on 28/09/2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation

public protocol DownloadExecutable: class {
    /// Build request and start REST download task
    ///
    /// - Parameters:
    ///   - route: request params
    ///   - completion: handler whith the running after get data
    /// - Returns: builded URLDownloadSessionTask
    @discardableResult
    func downloadRequest(_ route: RequestStructure, completion: @escaping (Response<URL>) -> Void) -> URLSessionDownloadTask?
}

public protocol RequestExecutable: class {
    
    /// Build request and start REST data task
    ///
    /// - Parameters:
    ///   - route: request params
    ///   - completion: handler whith the running after get response
    /// - Returns: builded URLDataSessionTask
    @discardableResult
    func dataRequest(_ route: RequestStructure, completion: @escaping (Response<Data>) -> Void) -> URLSessionDataTask?
}

public protocol ObjectRequestExecutable: class {
    
    /// /// Build request and start REST data task
    /// - Parameters:
    ///   - route: request params
    ///   - objectType: decoded type, which we should get as a result
    ///   - completion: builded URLDataSessionTask
    @discardableResult
    func objectRequest<ResponseObject: Decodable>(_ route: RequestStructure, objectType: ResponseObject.Type, completion: @escaping (Response<ResponseObject>) -> Void) -> URLSessionDataTask?
}
