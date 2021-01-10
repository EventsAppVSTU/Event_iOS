//
//  RegistrationFlow.swift
//  Flow
//
//  Created by Araik Garibian on 7/23/20.
//

import Library
import RxSwift


public enum RegistrationFlow: FlowProtocol {
	
	public struct Input {
        public let password: Observable<String>
		public let name: Observable<String>
		public let surname: Observable<String>
		public let organizationName: Observable<String>
        public let registrationButton: Observable<Void>
		public let backButton: Observable<Void>
        
        public init(
            password: Observable<String>,
			name: Observable<String>,
			surname: Observable<String>,
			organizationName: Observable<String>,
            registrationButton: Observable<Void>,
			backButton: Observable<Void>
		) {
            self.password = password
			self.name = name
			self.surname = surname
			self.organizationName = organizationName
            self.registrationButton = registrationButton
			self.backButton = backButton
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
