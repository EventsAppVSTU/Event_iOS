//
//  AuthFlow.swift
//  Views
//
//  Created by Araik Garibian on 5/29/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import Library
import RxSwift


public enum AuthFlow: FlowProtocol {
	
	public struct Input {
        public let password: Observable<String>
        public let email: Observable<String>
        public let loginButton: Observable<Void>
		public let registrationButton: Observable<Void>
        
        public init(
            email: Observable<String>,
            password: Observable<String>,
			loginButton: Observable<Void>,
			registrationButton: Observable<Void>
		) {
            self.email = email
            self.password = password
            self.loginButton = loginButton
			self.registrationButton = registrationButton
        }
    }

	public struct Output {
		public let serverMessages: Observable<Complete<String>>
		
		public init(
			serverMessages: Observable<Complete<String>>
		) {
			self.serverMessages = serverMessages
		}
	}
}

