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
    let phoneValue = PublishSubject<String>()
    let linkValue = PublishSubject<String>()
    let bioValue = PublishSubject<String>()
	let organizationNameValue = PublishSubject<String>()
	let registrationTapSubject = PublishSubject<Void>()
    let organizationList = BehaviorSubject<[Int: String]>(value: [:])
    let selectedOrganization = BehaviorSubject<Int?>(value: nil)
	let backTapSubject = PublishSubject<Void>()

	public override func bind(output: Flow.Output) {
        let sharedList = output.organizationList.share()

        sharedList
            .subscribe(organizationList)
            .disposed(by: bag)

        sharedList
            .map { _ in nil }
            .subscribe(selectedOrganization)
            .disposed(by: bag)

        sharedList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.contentView.organizationsListView.reloadAllComponents()
            })
            .disposed(by: bag)
	}

	public override var input: Flow.Input {
		return Flow.Input(
            login: loginValue.asObserver(),
			password: passwordValue.asObserver(),
			name: nameValue.asObserver(),
			surname: surnameValue.asObserver(),
			registrationButton: registrationTapSubject.asObserver(),
            backButton: backTapSubject.asObserver(),
            selectedOrganization: selectedOrganization.asObserver(),
            phone: phoneValue.asObserver(),
            bio: bioValue.asObserver(),
            link: linkValue.asObserver()
		)
	}

	public override func didLoad() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		contentView.addGestureRecognizer(tapGesture)

        contentView.organizationsListView.dataSource = self
        contentView.organizationsListView.delegate = self

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
		contentView.phoneField.corneredView.addTarget(
			self,
			action: #selector(textFieldValueChanged),
			for: .editingChanged
		)
        contentView.bioField.corneredView.addTarget(
            self,
            action: #selector(textFieldValueChanged),
            for: .editingChanged
        )
        contentView.linkField.corneredView.addTarget(
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
		} else if sender == contentView.phoneField.corneredView {
			phoneValue.onNext(sender.text ?? "")
		} else if sender == contentView.bioField.corneredView {
            bioValue.onNext(sender.text ?? "")
        } else if sender == contentView.linkField.corneredView {
            linkValue.onNext(sender.text ?? "")
        }
	}

	@objc func registrationButtonTap(_ sender: UIControl) {
		registrationTapSubject.on()
	}

	@objc func backButtonTap(_ sender: UIControl) {
		backTapSubject.on()
	}
}

extension RegistrationViewController: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    public func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        try! organizationList.value().count
    }
}

extension RegistrationViewController: UIPickerViewDelegate {
    public func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        let dict = try! organizationList.value()
        let keys = dict.keys.sorted()

        return dict[keys[row]]
    }

    public func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        let dict = try! organizationList.value()
        let keys = dict.keys.sorted()

        selectedOrganization.onNext(keys[row])
    }
}
