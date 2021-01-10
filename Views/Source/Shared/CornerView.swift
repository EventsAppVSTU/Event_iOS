//
//  CornerView.swift
//   
//
//  Created by user on 05/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

public class CornerView<T: UIView>: UIView {
	let corneredView: T

    private var leftContraint: NSLayoutConstraint!
    private var rightContraint: NSLayoutConstraint!

	public init(_ view: T, verticalSpacing: CGFloat = 0 ) {
        self.corneredView = view
        super.init(frame: .zero)

        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        leftContraint = view.leftAnchor.constraint(equalTo: leftAnchor)
        rightContraint = view.rightAnchor.constraint(equalTo: rightAnchor)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: verticalSpacing),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalSpacing),
            leftContraint,
			rightContraint
        ])
    }

	override public func layoutSubviews() {
        super.layoutSubviews()

        leftContraint.constant = frame.height / 2
        rightContraint.constant = frame.height / -2
        layer.cornerRadius = frame.height / 2
    }

	required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
