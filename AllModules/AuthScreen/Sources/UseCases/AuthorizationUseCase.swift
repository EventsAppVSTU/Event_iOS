//
//  AuthorizationUseCase.swift
//  AuthScreen
//
//  Created by Metalluxx on 27.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

import KeychainAccess
import Services

protocol AuthorizationUseCaseProtocol {
    func authorize(_ credential: Authorization.Credentials) -> Result<String, Error>
}

final class AuthorizationUseCase {
    
}
