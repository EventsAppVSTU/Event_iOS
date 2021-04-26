//
//  OrganizationsServiceProtocol.swift
//  Services
//
//  Created by Metalluxx on 27.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

import Foundation
import RxSwift

public extension Organizations {
    struct Description {
        public let id: Int
        public let name: String
    }
}

public extension OrganizationsServiceProtocol {
    typealias Response = Result<[Organizations.Description], Error>
}

public protocol OrganizationsServiceProtocol {
    func getOrganizations() -> Observable<Response>
}
