//
//  DividerTableViewCell.swift
//  Events
//
//  Created by Araik Garibian on 5/26/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

final internal class DividerTableViewCell: UITableViewCell {

	var dividerColor: UIColor? {
		get {
			return backgroundColor
		}
		set {
			backgroundColor = newValue
		}
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		backgroundColor = .systemGroupedBackground
		selectionStyle = .none

		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.heightAnchor.constraint(equalToConstant: 1).isActive = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
