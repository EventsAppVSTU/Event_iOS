//
//  RegistrationServiceProtocol.swift
//  Services
//
//  Created by Metalluxx on 18.04.2021.
//

import RxSwift

public protocol RegistrationServiceProtocol {
    func sendRegistrationRequest(_ body: Registration.RequestBody) -> Observable<Response>
}

public extension RegistrationServiceProtocol {
    typealias Response = Result<Registration.ResponseBody, Error>
}
