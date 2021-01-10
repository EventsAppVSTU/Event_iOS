//
//  EventTableViewCell.swift
//   
//
//  Created by user on 05/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Library
import RxSwift

class EventTableViewCell: UITableViewCell {

	var currentIndexPath: IndexPath?

	private let descriptionTap = PublishSubject<IndexPath>()
	private var descriptionTapDisposable: Disposable?

	let newsImageView = UIImageView()
		|> \.layer.cornerRadius .~ 10
		|> \.layer.masksToBounds .~ true

	let titleLabel = UILabel()
		|> \.font .~ .systemFont(ofSize: 25, weight: .semibold)
		|> \.numberOfLines .~ 2

	let dateLabel = UILabel()
		|> \.font .~ .systemFont(ofSize: 18, weight: .medium)
		|> \.textColor .~ .systemRed

	let descriptionLabel = UILabel()
		|> \.font .~ .systemFont(ofSize: 18, weight: .medium)
		|> \.numberOfLines .~ 4

	let mainStackView = UIStackView()
		|> \.spacing .~ 8
		|> \.axis .~ .vertical
		|> \.isLayoutMarginsRelativeArrangement .~ true
		|> \.layoutMargins .~ .init(top: 15, left: 15, bottom: 5, right: 15)
		|> \.translatesAutoresizingMaskIntoConstraints .~ false

	let detailedScreenButton = UIButton()
		|> sideEffect { $0.setTitle("Подробнее >", for: .normal) }
		|> sideEffect { $0.setTitleColor(.systemRed, for: .normal) }
		|> sideEffect { $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .light) }
		|> \.contentHorizontalAlignment .~ .left

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		detailedScreenButton.addTarget(self, action: #selector(tapToDescription), for: .touchUpInside)

		contentView.addSubview(mainStackView)
		mainStackView.insertArrangedSubview(newsImageView, at: 0)
		mainStackView.insertArrangedSubview(titleLabel, at: 1)
		mainStackView.insertArrangedSubview(dateLabel, at: 2)
		mainStackView.insertArrangedSubview(descriptionLabel, at: 3)
		mainStackView.insertArrangedSubview(detailedScreenButton, at: 4)

		NSLayoutConstraint.activate([
			mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor, multiplier: 3 / 5)
		])
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		currentIndexPath = nil
		descriptionTapDisposable?.dispose()
		descriptionTapDisposable = nil
	}

	public func connectDescriptionTap<S>(to destination: S) where S: ObserverType, S.Element == IndexPath {
		descriptionTapDisposable = descriptionTap.subscribe(destination)
	}

	@objc func tapToDescription() {
		guard let currentIndexPath = currentIndexPath else { return }
		descriptionTap.onNext(currentIndexPath)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func setSelected(_ selected: Bool, animated: Bool) {}
	override func setHighlighted(_ highlighted: Bool, animated: Bool) {}

}
