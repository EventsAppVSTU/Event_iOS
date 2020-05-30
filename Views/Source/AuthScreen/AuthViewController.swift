//
//  ViewController.swift
//   
//
//  Created by user on 04/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Library
import Combine


public class AuthViewController: BaseViewController<AuthView, AuthFlow> {
	public override func bind(output: Flow.Output) {
		output.serverMessages
		.sink {
			print($0)
		}
		.store(in: &self.store)
	}

	public override var input: Flow.Input {
		Flow.Input(
			email: contentView.loginField.corneredView.textPublisher.map { $0 == nil ? "" : $0! }.eraseToAnyPublisher(),
			password: contentView.passField.corneredView.textPublisher.map { $0 == nil ? "" : $0! }.eraseToAnyPublisher(),
			loginButton: contentView.loginBtn.corneredView.tapPublisher
		)
	}
	
    public override func viewDidLoad() {
        super.viewDidLoad()
		
		bind(output: viewModel.transform(input: self.input, bag: &store))
		
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		contentView.addGestureRecognizer(tapGesture)
		contentView.loginBtn.corneredView.addTarget(self, action: #selector(navigateToEvent), for: .touchUpInside)
    }
	
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
	
	@objc func navigateToEvent() {}
}

