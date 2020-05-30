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
import Flow

public class AuthViewController: BaseViewController<AuthView, AuthFlow> {
	
	@Published var loginValue = ""
	@Published var passwordValue = ""
	
	let loginTapSubject = PassthroughSubject<Void, Never>()
	
	public override func bind(output: Flow.Output) {
		output.serverMessages
			.receive(on: DispatchQueue.main)
			.sink {
				print($0)
			}
			.store(in: &self.bag)
	}

	public override var input: Flow.Input {
		Flow.Input(
			email: $loginValue.eraseToAnyPublisher(),
			password: $passwordValue.eraseToAnyPublisher(),
			loginButton: loginTapSubject.eraseToAnyPublisher()
		)
	}
	
	public override func didLoad() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		contentView.addGestureRecognizer(tapGesture)
		
		contentView.loginBtn.corneredView.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
		contentView.loginField.corneredView.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
		contentView.passField.corneredView.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
	}
	
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
	
	@objc func textFieldValueChanged(_ sender: UITextField) {
		if sender == contentView.loginField.corneredView {
			loginValue = sender.text ?? ""
		}
		else if sender == contentView.passField.corneredView {
			passwordValue = sender.text ?? ""
		}
	}
	
	@objc func loginButtonTap(_ sender: UIControl) {
		loginTapSubject.send()
	}
}



