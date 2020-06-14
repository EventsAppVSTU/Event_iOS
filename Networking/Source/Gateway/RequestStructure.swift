//
//  EndPoint.swift
//  MDW
//
//  Created by Metalluxx on 02/04/2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import UIKit

public protocol RequestStructure {
    /// Server URL
    var baseURL: URL { get }
    
    var path: [String] { get }
    
    var body: HTTPBody { get }
    
    var urlParams: [String: String?]? { get }
    
    var contentType: ContentType { get }
    
    /// REST API method
    var httpMethod: HTTPMethod { get }
    
    var encoderConfigure: ((JSONEncoder) -> Void)? { get }
    
	var decoderConfigure: ((JSONDecoder) -> Void)? { get }
	
    var headers: [String: String]? { get }
    
    static var sharedHeaders: [String: String]? { get }
}

