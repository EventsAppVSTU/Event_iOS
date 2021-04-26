//
//  AuthView.swift
//   
//
//  Created by Araik Garibian on 5/18/20.
//  Copyright © 2020 user. All rights reserved.
//

import DesignEngine
import AppFoundation
import Overture

public class RegistrationView: UIView {
	public let backgroundView = UIImageView(image: UIImage(named: "loginBackground"))

	public let backButton = UIButton()
		|> sideEffect {
			$0.setTitle("Назад", for: .normal)
			$0.setTitleColor(.systemRed, for: .normal)
			$0.setTitleColor(UIColor.systemRed.withAlphaComponent(0.5), for: .highlighted)
		}

	public let registrationButton =
		CornerView(UIButton(), verticalSpacing: 5)
			|> \.backgroundColor .~ .systemRed
			|> sideEffect(^\.corneredView >>> sideEffect(flip(UIButton.setTitleColor)(.white, .normal)))
			|> sideEffect(^\.corneredView >>> sideEffect(flip(UIButton.setTitleColor)(.black, .highlighted)))
			|> sideEffect(^\.corneredView >>> sideEffect(flip(UIButton.setTitle)("Регистрация", .normal)))

	static func buildTextField(text: String) -> CornerView<UITextField> {
		return CornerView(UITextField(), verticalSpacing: 10)
			|> \.corneredView.borderStyle .~ .none
			|> \.corneredView.textColor .~ .init(
				dynamicProvider: { $0.userInterfaceStyle == .dark ? .white : .black })
			|> \.corneredView.attributedPlaceholder .~ .init(
				string: text,
				attributes: [.foregroundColor: UIColor.gray.withAlphaComponent(0.4)])
			|> \.backgroundColor .~ .systemBackground
			|> \.layer.borderColor .~ UIColor.gray.withAlphaComponent(0.4).cgColor
			|> \.layer.borderWidth .~ 1
	}

	public let passField =
		CornerView(UITextField(), verticalSpacing: 10)
			|> \.corneredView.borderStyle .~ .none
			|> \.corneredView.textColor .~ .init(
				dynamicProvider: { $0.userInterfaceStyle == .dark ? .white : .black })
			|> \.corneredView.attributedPlaceholder .~ .init(
				string: "Пароль",
				attributes: [.foregroundColor: UIColor.gray.withAlphaComponent(0.4)])
			|> \.backgroundColor .~ .systemBackground
			|> \.layer.borderColor .~ UIColor.gray.withAlphaComponent(0.4).cgColor
			|> \.layer.borderWidth .~ 1

    public let loginField =
		CornerView(UITextField(), verticalSpacing: 10)
			|> \.corneredView.borderStyle .~ .none
			|> \.corneredView.textColor .~ .init(
				dynamicProvider: { $0.userInterfaceStyle == .dark ? .white : .black })
			|> \.corneredView.attributedPlaceholder .~ .init(
				string: "Логин",
				attributes: [.foregroundColor: UIColor.gray.withAlphaComponent(0.4)])
			|> \.backgroundColor .~ .systemBackground
			|> \.layer.borderColor .~ UIColor.gray.withAlphaComponent(0.4).cgColor
			|> \.layer.borderWidth .~ 1

    public let nameField = buildTextField(text: "Имя")
	public let surnameField = buildTextField(text: "Фамилия")
	public let phoneField = buildTextField(text: "Телефон")
    public let linkField = buildTextField(text: "Ссылка")
    public let bioField = buildTextField(text: "Биография")
    public let organizationsListView = UIPickerView()

	public lazy private(set) var credentialtackView =
		UIStackView(
			arrangedSubviews: [loginField, passField, nameField, surnameField, phoneField, linkField, bioField, organizationsListView, registrationButton]
		)
			|> \.spacing .~ 8
			|> \.axis .~ .vertical
			|> \.translatesAutoresizingMaskIntoConstraints .~ false

	override public init(frame: CGRect) {
		super.init(frame: frame)

        backgroundColor = .systemBackground

		[credentialtackView, backButton, backgroundView]
			.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        insertSubview(credentialtackView, at: 1)
		insertSubview(backButton, at: 1)
		insertSubview(backgroundView, at: 0)

        NSLayoutConstraint.activate([
            credentialtackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            credentialtackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            credentialtackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

			backButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            backButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
