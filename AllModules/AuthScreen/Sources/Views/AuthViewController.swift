//
//  ViewController.swift
//   
//
//  Created by user on 04/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import DesignEngine
import Platform
import RxSwift

public class AuthViewController: BaseViewController<AuthView, AuthFlow> {
	let loginValue = PublishSubject<String>()
	let passwordValue = PublishSubject<String>()
	let loginTapSubject = PublishSubject<Void>()
	let registrationTapSubject = PublishSubject<Void>()

	public override func bind(output: Flow.Output) {}

	public override var input: Flow.Input {
		Input(
			email: loginValue.asObserver(),
			password: passwordValue.asObserver(),
			loginButton: loginTapSubject.asObserver(),
			registrationButton: registrationTapSubject.asObserver()
		)
	}

	public override func didLoad() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		contentView.addGestureRecognizer(tapGesture)

		contentView.loginBtn.corneredView.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
		contentView.registrationButton.addTarget(self, action: #selector(registrationButtonTap), for: .touchUpInside)
		contentView.loginField.corneredView.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
		contentView.passField.corneredView.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
	}

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

	@objc func textFieldValueChanged(_ sender: UITextField) {
		if sender == contentView.loginField.corneredView {
			loginValue.onNext(sender.text ?? "")
		} else if sender == contentView.passField.corneredView {
			passwordValue.onNext(sender.text ?? "")
		}
	}

	@objc func loginButtonTap(_ sender: UIControl) {
		loginTapSubject.on()
	}

	@objc func registrationButtonTap(_ sender: UIControl) {
		registrationTapSubject.on()
	}
}
