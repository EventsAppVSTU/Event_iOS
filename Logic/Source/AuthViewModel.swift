//
//  AuthViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/30/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import Library
import Combine
import Views

public class AuthViewModel: BaseViewModel<AuthFlow> {
	
	let globalContext: GlobalContext
	
	struct Credential {
		let email: String
		let password: String
	}
	
	public init(globalContext: GlobalContext) {
		self.globalContext = globalContext
		super.init()
	}
	
	private var serverResponse = PassthroughSubject<Complete<String>, Never>()
	
	public override func transform(input: AuthFlow.Input, bag: inout Set<AnyCancellable>) -> AuthFlow.Output {
		let cred = Publishers.CombineLatest(input.email, input.password)
			.map { Credential(email: $0.0, password: $0.1) }
		
		input.loginButton
			.combineLatest(cred) { $1 }
			.sink(receiveValue: unowned(serverResponse) { (instance, arg) in
				instance.send(arg.email == arg.password ? .success : .failure(error: "SASI"))
			})
			.store(in: &bag)
		
		return AuthFlow.Output(serverMessages: serverResponse.eraseToAnyPublisher())
	}
}
