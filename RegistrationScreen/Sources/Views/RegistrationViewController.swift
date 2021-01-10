//
//  ViewController.swift
//   
//
//  Created by user on 04/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import DesignEngine
import RxSwift
import Platform

public class RegistrationViewController: BaseViewController<RegistrationView, RegistrationFlow> {

	let loginValue = PublishSubject<String>()
	let passwordValue = PublishSubject<String>()
	let nameValue = PublishSubject<String>()
	let surnameValue = PublishSubject<String>()
	let organizationNameValue = PublishSubject<String>()
	let registrationTapSubject = PublishSubject<Void>()
	let backTapSubject = PublishSubject<Void>()

	public override func bind(output: Flow.Output) {
		output.serverMessages
			.subscribe {
				print($0)
			}
			.disposed(by: bag)
	}

	public override var input: Flow.Input {
		return Flow.Input(
			password: passwordValue.asObserver(),
			name: nameValue.asObserver(),
			surname: surnameValue.asObserver(),
			organizationName: organizationNameValue.asObserver(),
			registrationButton: registrationTapSubject.asObserver(),
			backButton: backTapSubject.asObserver()
		)
	}

	public override func didLoad() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		contentView.addGestureRecognizer(tapGesture)

		contentView.backButton.addTarget(
			self,
			action: #selector(backButtonTap),
			for: .touchUpInside
		)
		contentView.registrationButton.corneredView.addTarget(
			self,
			action: #selector(registrationButtonTap),
			for: .touchUpInside
		)
		contentView.loginField.corneredView.addTarget(
			self,
			action: #selector(textFieldValueChanged),
			for: .editingChanged
		)
		contentView.passField.corneredView.addTarget(
			self,
			action: #selector(textFieldValueChanged),
			for: .editingChanged
		)
		contentView.nameField.corneredView.addTarget(
			self,
			action: #selector(textFieldValueChanged),
			for: .editingChanged
		)
		contentView.surnameField.corneredView.addTarget(
			self,
			action: #selector(textFieldValueChanged),
			for: .editingChanged
		)
		contentView.organizationNameField.corneredView.addTarget(
			self,
			action: #selector(textFieldValueChanged),
			for: .editingChanged
		)
	}

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

	@objc func textFieldValueChanged(_ sender: UITextField) {
		if sender == contentView.loginField.corneredView {
			loginValue.onNext(sender.text ?? "")
		} else if sender == contentView.passField.corneredView {
			passwordValue.onNext(sender.text ?? "")
		} else if sender == contentView.nameField.corneredView {
			nameValue.onNext(sender.text ?? "")
		} else if sender == contentView.surnameField.corneredView {
			surnameValue.onNext(sender.text ?? "")
		} else if sender == contentView.organizationNameField.corneredView {
			organizationNameValue.onNext(sender.text ?? "")
		}
	}

	@objc func registrationButtonTap(_ sender: UIControl) {
		registrationTapSubject.on()
	}

	@objc func backButtonTap(_ sender: UIControl) {
		backTapSubject.on()
	}
}
