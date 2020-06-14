//
//  Notification.swift
//  ClusterMonitor
//
//  Created by Metalluxx on 30/04/2019.
//  Copyright © 2019 Metalluxx. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil
    case encodingFailed
    case missingURL
}

public enum NetworkResponse: String, Error {
    case success
    case unableCastResponse = "Could not get response"
    case dontConnectionInternet = "Please check your network connection"
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case incorrectUrl = "Unable to convert string to link"
}
