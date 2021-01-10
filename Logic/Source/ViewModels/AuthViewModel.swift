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

public extension AuthViewModel {
	struct Credential {
		public let email: String
		public let password: String

		public init(email: String, password: String) {
			self.email = email
			self.password = password
		}
	}
}

public class AuthViewModel: BaseViewModel<AuthFlow> {
	let globalContext: GlobalContext

	public init(globalContext: GlobalContext) {
		self.globalContext = globalContext
		super.init()
	}

	private var serverResponse = PublishSubject<Complete<String>>()

	public override func transform(input: AuthFlow.Input, bag: DisposeBag) -> AuthFlow.Output {
		let cred = Observable
			.combineLatest(input.email, input.password)
			.observe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .utility)))
			.map(Credential.init)

		let sharedLoginButton = input.loginButton.share()

		sharedLoginButton.withLatestFrom(cred)
			.observe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .utility)))
			.map { String(describing: $0) }
			.map { Complete.failure(error: $0) }
			.subscribe(serverResponse)
			.disposed(by: bag)

		sharedLoginButton
			.observe(on: MainScheduler.instance )
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
			.observe(on:
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
