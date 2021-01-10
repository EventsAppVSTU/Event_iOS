//
//  NewsContentView.swift
//  Views
//
//  Created by Araik Garibian on 5/31/20.
//

import UIKit
import Library

internal class NewsContentView: UIView {

	let textLabel = UITextView()
		|> sideEffect {
			$0.isScrollEnabled = false
			$0.font = .systemFont(ofSize: 20, weight: .regular)
			$0.textColor = .init(dynamicProvider: { $0.userInterfaceStyle == .dark ? .white : .black })
		}

	let descriptionLabel = UILabel()
		|> \.numberOfLines .~ 0
		|> \.font .~ .systemFont(ofSize: 25, weight: .regular)
		|> \.textColor .~ .systemRed

	private var stackView: UIStackView!

	override init(frame: CGRect) {
		super.init(frame: frame)

		let stackView = UIStackView(
			arrangedSubviews: [descriptionLabel, textLabel]
		)
		stackView.axis = .vertical
		stackView.spacing = 20
		stackView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
			stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
			stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
