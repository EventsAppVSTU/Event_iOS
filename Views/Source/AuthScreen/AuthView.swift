//
//  AuthView.swift
//   
//
//  Created by Araik Garibian on 5/18/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Library
import Overture

public class AuthView: UIView {
	public let backgroundView = UIImageView(image: UIImage(named: "loginBackground"))
	
	public let loginBtn =
		CornerView(UIButton(), verticalSpacing: 5)
			|> \.backgroundColor .~ .systemRed
			|> sideEffect(^\.corneredView >>> sideEffect(flip(UIButton.setTitleColor)(.white, .normal)))
			|> sideEffect(^\.corneredView >>> sideEffect(flip(UIButton.setTitleColor)(.black, .highlighted)))
			|> sideEffect(^\.corneredView >>> sideEffect(flip(UIButton.setTitle)("Вход", .normal)))

	public let passField =
		CornerView(UITextField(), verticalSpacing: 10)
			|> \.corneredView.borderStyle .~ .none
			|> \.corneredView.textColor .~ .init(
				dynamicProvider:{ $0.userInterfaceStyle == .dark ? .white : .black })
			|> \.corneredView.attributedPlaceholder .~ .init(
				string: "Пароль",
				attributes: [.foregroundColor : UIColor.gray.withAlphaComponent(0.4)])
			|> \.backgroundColor .~ .systemBackground
			|> \.layer.borderColor .~ UIColor.gray.withAlphaComponent(0.4).cgColor
			|> \.layer.borderWidth .~ 1
	
    public let loginField =
		CornerView(UITextField(), verticalSpacing: 10)
			|> \.corneredView.borderStyle .~ .none
			|> \.corneredView.textColor .~ .init(
				dynamicProvider:{ $0.userInterfaceStyle == .dark ? .white : .black })
			|> \.corneredView.attributedPlaceholder .~ .init(
				string: "Логин",
				attributes: [.foregroundColor : UIColor.gray.withAlphaComponent(0.4)])
			|> \.backgroundColor .~ .systemBackground
			|> \.layer.borderColor .~ UIColor.gray.withAlphaComponent(0.4).cgColor
			|> \.layer.borderWidth .~ 1
	
	public lazy private(set) var credentinalStackView =
		UIStackView(arrangedSubviews: [loginField, passField, loginBtn])
			|> \.spacing .~ 8
			|> \.axis .~ .vertical
			|> \.translatesAutoresizingMaskIntoConstraints .~ false
	
	public let brandStackView: UIStackView = {
        let image = UIImage(named: "brandLogo")
        let imageView = UIImageView(image: image)
        
        let brandLabel = UILabel()
			|> \.text .~ "Event \nApp"
			|> \.numberOfLines .~ 2
			|> \.font .~ .systemFont(ofSize: 48, weight: .light)
        
        let brandStackView = UIStackView(arrangedSubviews: [imageView, brandLabel])
			|> \.axis .~ .horizontal
			|> \.spacing .~ 8
        
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        brandLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        brandLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return brandStackView
    }()

	public let registrationButton = UIButton()
		|> sideEffect {
			$0.setTitle("Регистрация", for: .normal)
			$0.setTitleColor(.systemRed, for: .normal)
			$0.setTitleColor(UIColor.systemRed.withAlphaComponent(0.5), for: .highlighted)
		}
    
	override public init(frame: CGRect) {
		super.init(frame: frame)
		
        backgroundColor = .systemBackground
        
        let footerLayoutGuide = UILayoutGuide()
        addLayoutGuide(footerLayoutGuide)
		
		[credentinalStackView, brandStackView, registrationButton, backgroundView]
			.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		
        insertSubview(credentinalStackView, at: 1)
		insertSubview(brandStackView, at: 1)
		insertSubview(registrationButton, at:1)
		insertSubview(backgroundView, at:0)
		
        NSLayoutConstraint.activate([
			footerLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			footerLayoutGuide.bottomAnchor.constraint(equalTo: self.credentinalStackView.topAnchor),
			footerLayoutGuide.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			footerLayoutGuide.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			
            credentinalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            credentinalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            credentinalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			
            brandStackView.centerYAnchor.constraint(equalTo: footerLayoutGuide.centerYAnchor),
            brandStackView.centerXAnchor.constraint(equalTo: footerLayoutGuide.centerXAnchor),
			
			registrationButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            registrationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
