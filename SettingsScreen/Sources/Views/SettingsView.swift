//
//  SettingsView.swift
//  Events
//
//  Created by Araik Garibian on 5/24/20.
//  Copyright © 2020 user. All rights reserved.
//

import DesignEngine
import Overture
import AppFoundation

public class SettingsView: UIView {

	let exitButton = CornerView(UIButton())
		|> \.backgroundColor .~ .systemRed
		|> sideEffect {
			$0.corneredView.setTitle("Выход", for: .normal)
			$0.corneredView.titleLabel?.font = .systemFont(ofSize: 25, weight: .light)
		}

	let personNameLabel = UILabel()
		|> \.font .~ .systemFont(ofSize: 30, weight: .light)
		|> \.text .~ "Araik"
		|> \.textAlignment .~ .center

	let personAvatarView = UIImageView()
		|> \.clipsToBounds .~ true
		|> \.contentMode .~ .scaleAspectFill

	let tableView = UITableView()
	let bottomBarLayout = UILayoutGuide()
	let footerBarLayout = UILayoutGuide()

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .systemBackground

		[exitButton, personNameLabel, tableView, personAvatarView].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}

		addLayoutGuide(bottomBarLayout)
		addLayoutGuide(footerBarLayout)

		NSLayoutConstraint.activate([
			exitButton.centerYAnchor.constraint(equalTo: bottomBarLayout.centerYAnchor),
			exitButton.centerXAnchor.constraint(equalTo: bottomBarLayout.centerXAnchor),

			footerBarLayout.heightAnchor.constraint(equalToConstant: 180),
			footerBarLayout.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			footerBarLayout.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			footerBarLayout.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),

			personAvatarView.heightAnchor.constraint(equalTo: personAvatarView.widthAnchor),
			personAvatarView.centerXAnchor.constraint(equalTo: footerBarLayout.centerXAnchor),
			personAvatarView.topAnchor.constraint(equalTo: footerBarLayout.topAnchor, constant: 5),
			personAvatarView.bottomAnchor.constraint(equalTo: personNameLabel.topAnchor, constant: -5),

			bottomBarLayout.heightAnchor.constraint(equalToConstant: 80),
			bottomBarLayout.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			bottomBarLayout.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			bottomBarLayout.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),

			personNameLabel.bottomAnchor.constraint(equalTo: footerBarLayout.bottomAnchor, constant: -5),
			personNameLabel.centerXAnchor.constraint(equalTo: footerBarLayout.centerXAnchor),
			personNameLabel.leftAnchor.constraint(greaterThanOrEqualTo: footerBarLayout.leftAnchor),
			personNameLabel.rightAnchor.constraint(lessThanOrEqualTo: footerBarLayout.rightAnchor),

			tableView.topAnchor.constraint(equalTo: footerBarLayout.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomBarLayout.topAnchor)
		])

		personAvatarView.setContentCompressionResistancePriority(.defaultLow - 1, for: .vertical)
		personAvatarView.setContentCompressionResistancePriority(.defaultLow - 1, for: .horizontal)
		personNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
		personNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
		personAvatarView.layer.cornerRadius = personAvatarView.frame.size.width / 2
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
