//
//  RegistrationViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 7/23/20.
//

import Foundation
import Library
import RxSwift
import Views
import Flow
import UIKit


public class RegistrationViewModel: BaseViewModel<RegistrationFlow> {
	let globalContext: GlobalContext
	
	struct Credential {
		let email: String
		let password: String
		let name: String
		let surname: String
		let organizationName: String
	}
	
	public override func transform(input: RegistrationFlow.Input, bag: DisposeBag) -> RegistrationFlow.Output {
		
		input.backButton
			.map { [weak self] in self?.globalContext }
			.subscribe(onNext: {
				guard let context = $0 else { return }
				context.globalNavigationController.popViewController(animated: true)
			})
			.disposed(by: bag)
		
		return Output(
			serverMessages: .create {
				$0.onNext(.success)
				
				return Disposables.create()
			}
		)
	}
	
	public init(globalContext: GlobalContext) {
		self.globalContext = globalContext
		super.init()
	}
}
