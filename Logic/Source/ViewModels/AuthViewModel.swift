//
//  AuthViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/30/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import Library
import RxSwift
import Views
import Flow

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
	
	private var serverResponse = PublishSubject<Complete<String>>()
	
	public override func transform(input: AuthFlow.Input, bag: DisposeBag) -> AuthFlow.Output {
		input.loginButton
			.subscribe(
				onNext: unowned(globalContext, { (instance, _) in
					let screen = ScreenBuilder.getMainScreen(context: instance)
					instance.globalNavigationController.setViewControllers([screen], animated: true)
				})
			)
			.disposed(by: bag)
		
		return AuthFlow.Output(serverMessages: serverResponse.asObserver())
	}
}
