//
//  NetworkRouter.swift
//  MDW
//
//  Created by Metalluxx on 02/04/2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation
import Library

/// Default gateway
open class Gateway {
    // MARK: Vars
	public private(set) var session: URLSession
    
    // MARK: Init and deinit
	public init(session: URLSession = .shared) {
		self.session = session
	}

	private func debugPrint(_ request: RequestStructure, _ msg: String) {
		print("\(type(of: self))[\(Unmanaged.passUnretained(self).toOpaque())] " + "\(request.baseURL.relativeString) - \(msg)")
	}
	
    // MARK: Form requests
    private func buildRequest(from route: RequestStructure) throws -> URLRequest {
		
		debugPrint(route, "Start building URL components")
		
        guard var component = URLComponents(
            url: route.baseURL.appendingPathComponent(route.path),
            resolvingAgainstBaseURL: false)
        else
		{
			debugPrint(route, "Build URL components incompleted: \(NetworkError.missingURL.localizedDescription)")
            throw NetworkError.missingURL
        }
		
		debugPrint(route, "Build URL components completed")
		
        component.queryItems = route.urlParams?.queryItems
		
		debugPrint(route, "Start building main URL")
		
        guard let url = component.url else {
			debugPrint(route, "Build main URL incompleted: \(NetworkError.missingURL.localizedDescription)")
			throw NetworkError.missingURL
		}
        
		debugPrint(route, "Build main URL completed")
		
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
		
        request.httpMethod = route.httpMethod.rawValue
        request.addHeaders(["Content-Type": route.contentType.rawValue])
        request.addHeaders(route.headers)
        request.addHeaders(type(of: route).sharedHeaders)
		
		if case HTTPBody.none = route.body {}
		else {
			do {
				let encoder = JSONEncoder()
				route.encoderConfigure?(encoder)
				request.httpBody = try encoder.encode(route.body)
			}
			catch {
				throw error
			}
		}

		return request
    }
}


extension Gateway: DownloadExecutable {
    // MARK: Create requests
    @discardableResult
    open func downloadRequest (_ route: RequestStructure, completion: @escaping (Response<URL>) -> Void) -> URLSessionDownloadTask? {
		
        var task: URLSessionDownloadTask?
        
		debugPrint(route, "Create task")
		
		do {
			debugPrint(route, "Trying build native request")
			
            let request = try buildRequest(from: route)
			
			debugPrint(route, "Request builded")
			
            task = session.downloadTask(with: request) {
				(url, response, error) in
				
                if let error = error
				{
                    let errorBundle = ErrorResponse(error, for: URL.self, response: response, request: request)
                    completion(.failure(info: errorBundle))
                    return
                }
				
                guard let url = url else
				{
                    let errorBundle = ErrorResponse(NetworkResponse.noData, for: URL.self, response: response, request: request)
                    completion(.failure(info: errorBundle))
                    return
                }
				
                completion(.completed(info: CompleteResponse(url, response: response, request: request)))
            }
			
        }
		catch let error {
            let errorBundle = ErrorResponse(error, for: URL.self, response: nil, request: nil)
            completion(.failure(info: errorBundle))
        }
        
        guard let buildedTask = task else { return nil }
		
        buildedTask.resume()
		
        return buildedTask
    }
}


extension Gateway: RequestExecutable {
    @discardableResult
    open func dataRequest( _ route: RequestStructure, completion: @escaping (Response<Data>) -> Void ) -> URLSessionDataTask? {
        
		var task: URLSessionDataTask?
		debugPrint(route, "Start creating task")
		
        do {
			debugPrint(route, "Trying build native request")
			
            let request = try self.buildRequest(from: route)
			
			debugPrint(route, "Request builded")
			
            task = session.dataTask(with: request) {
				[weak self] (data, response, error) in
                
				if let error = error
				{
                    let errorBundle = ErrorResponse(error, for: Data.self, response: response, request: request)
                    completion(.failure(info: errorBundle))
					self?.debugPrint(route, "Session error: \(error.localizedDescription)")
                    return
                }
                
				guard let data = data else
				{
                    let errorBundle = ErrorResponse(NetworkResponse.noData, for: Data.self, response: response, request: request)
                    completion(.failure(info: errorBundle))
					self?.debugPrint(route, "Data error: \(NetworkResponse.noData)")
                    return
                }
				
                let completeBundle = CompleteResponse(data, response: response, request: request)
                completion(.completed(info: completeBundle))
            }
        }
		catch {
            let errorBundle = ErrorResponse(error, for: Data.self, response: nil, request: nil)
            completion(.failure(info: errorBundle))
			debugPrint(route, "Request completed")
        }

        guard let buildedTask = task else { return nil }
        
        buildedTask.resume()
        
		return buildedTask
    }
}


extension Gateway: ObjectRequestExecutable {
    @discardableResult open func objectRequest<ResponseObject: Decodable>(_ route: RequestStructure, objectType: ResponseObject.Type, completion: @escaping (Response<ResponseObject>) -> Void) -> URLSessionDataTask?
    {
        self.dataRequest(route) {
			(result) in
            
			switch result {
            case .completed(let info):
                do {
                    if ResponseObject.self == String.self {
                        if let str = String(data: info.arrivalObject, encoding: .utf8)
						{
                            let completeBundle = CompleteResponse(str, from: info)
                            completion(.completed(info: completeBundle as! CompleteResponse<ResponseObject>))
                        }
						else
						{
                            let errorBundle = ErrorResponse(NetworkError.encodingFailed, for: ResponseObject.self, from: info)
                            completion(.failure(info: errorBundle))
                        }
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    route.decoderConfigure?(decoder)
                    let object = try decoder.decode(ResponseObject.self, from: info.arrivalObject)

                    let completeBundle = CompleteResponse(object, from: info)
                    completion(.completed(info: completeBundle))
                }
				catch let error {
                    completion(.failure(info: ErrorResponse(error, for: ResponseObject.self, from: info)))
                }
			
			case .failure(let info):
                completion(.failure(info: ErrorResponse(for: ResponseObject.self, from: info)))
            }
        }
    }
}


fileprivate extension JSONDecoder {
    func set<T>(_ keyPath: ReferenceWritableKeyPath<JSONDecoder, T>, value: T) -> JSONDecoder {
        self[keyPath: keyPath] = value
        return self
    }
}


fileprivate extension JSONEncoder {
    func set<T>(_ keyPath: ReferenceWritableKeyPath<JSONEncoder, T>, value: T) -> JSONEncoder {
        self[keyPath: keyPath] = value
        return self
    }
}
