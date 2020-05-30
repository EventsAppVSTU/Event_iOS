//
//  AuthFlow.swift
//  Views
//
//  Created by Araik Garibian on 5/29/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import Library
import Combine

public enum AuthFlow: FlowProtocol {
	
	public struct Input {
        public let password: AnyPublisher<String, Never>
        public let email: AnyPublisher<String, Never>
        public let loginButton: AnyPublisher<Void, Never>
        
        public init(
            email: AnyPublisher<String, Never>,
            password: AnyPublisher<String, Never>,
            loginButton: AnyPublisher<Void, Never>
		) {
            self.email = email
            self.password = password
            self.loginButton = loginButton
        }
    }

	public struct Output {
		public let serverMessages: AnyPublisher<Complete<String>, Never>
		
		public init(
			serverMessages: AnyPublisher<Complete<String>, Never>
		) {
			self.serverMessages = serverMessages
		}
	}
}
