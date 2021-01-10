//
//  SimpleCell.swift
//  Events
//
//  Created by Araik Garibian on 5/26/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Library

public struct SimpleCellItem: Hashable {
	public let title: String
	public let leftImage: Image?
	public let rightImage: Image?
}

public class SimpleCell: UITableViewCell {

	let leftIconView = UIImageView()
	let rightIconView = UIImageView()
	let titleLabel = UILabel()

	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		[titleLabel, leftIconView, rightIconView].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview($0)
		}

		leftIconView.tintColor = .systemRed
		rightIconView.tintColor = .systemRed

		NSLayoutConstraint.activate([
			leftIconView.heightAnchor.constraint(equalTo: leftIconView.widthAnchor),
			rightIconView.heightAnchor.constraint(equalTo: rightIconView.widthAnchor),
			leftIconView.heightAnchor.constraint(equalToConstant: 35),
			rightIconView.heightAnchor.constraint(equalToConstant: 35),

			leftIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			leftIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			rightIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			rightIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

			leftIconView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
			rightIconView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),

			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			titleLabel.leftAnchor.constraint(equalTo: leftIconView.rightAnchor, constant: 10),
			titleLabel.rightAnchor.constraint(lessThanOrEqualTo: rightIconView.leftAnchor, constant: -5)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
