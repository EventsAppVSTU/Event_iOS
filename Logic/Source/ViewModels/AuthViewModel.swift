//
//  AuthViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/30/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import Foundation
import Library
import RxSwift
import Views
import Flow
import UIKit

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
		
		let cred = Observable
			.combineLatest(input.email, input.password)
			.observeOn(
				ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .utility))
			)
			.map { (login: String, password: String) -> Credential in
				Credential(email: login, password: password)
			}
		
		let sharedLoginButton = input.loginButton.share()
		
		sharedLoginButton.withLatestFrom(cred)
			.observeOn(
				ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .utility))
			)
			.map {
				String(describing: $0)
			}
			.map {
				Complete.failure(error: $0)
			}
			.subscribe(serverResponse)
			.disposed(by: bag)
		
		sharedLoginButton
			.observeOn(
				MainScheduler.instance
			)
			.map(
				unowned(globalContext) {
					return (
						vc: ScreenBuilder.getMainScreen(context: $0),
						context: $0
					)
				}
			)
			.subscribe(onNext: {
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
				$0.context.globalNavigationController.setViewControllers([$0.vc], animated: true)
			})
			.disposed(by: bag)
		
		
		input
			.registrationButton
			.observeOn(
				MainScheduler.instance
			)
			.map { [weak self] in self?.globalContext }
			.subscribe(onNext: {
				guard let context = $0 else { return }
				context.globalNavigationController.pushViewController(
					RegistrationViewController(viewModel: RegistrationViewModel(globalContext: context)),
					animated: true
				)
			})
			.disposed(by: bag)
		
		return AuthFlow.Output(
			serverMessages: serverResponse.asObserver()
		)
	}
}
