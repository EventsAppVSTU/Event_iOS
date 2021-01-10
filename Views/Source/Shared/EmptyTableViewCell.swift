//
//  EmptyTableViewCell.swift
//  Events
//
//  Created by Araik Garibian on 5/25/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

final class EmptyTableViewCell: UITableViewCell {

	var cellHeight: CGFloat {
		get {
			return cellHeightConstraint.constant
		}
		set {
			cellHeightConstraint.constant = newValue
		}
	}

	private var cellHeightConstraint: NSLayoutConstraint!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		selectionStyle = .none
		contentView.translatesAutoresizingMaskIntoConstraints = false
		cellHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 50)
		cellHeightConstraint.isActive = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
