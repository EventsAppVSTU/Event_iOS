//
//  NewsView.swift
//  Events
//
//  Created by Araik Garibian on 5/26/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Library

public class NewsView: UIView {

	private var heightBannerConstraint: NSLayoutConstraint!

	let animatableBannerLayout = UILayoutGuide()

	let rootScrollView = UIScrollView()
		|> \.backgroundColor .~ .clear
		|> \.alwaysBounceVertical .~ true
		|> \.clipsToBounds .~ false

	let titleLabel = UILabel()
		|> \.numberOfLines .~ 0
		|> \.font .~ .systemFont(ofSize: 40, weight: .heavy)
		|> \.textColor .~ .white
		|> sideEffect { $0.drawShadow() }

	lazy var infoStackView = UIStackView(arrangedSubviews: [titleLabel])
		|> \.axis .~ .vertical
		|> \.spacing .~ 8
		|> sideEffect { $0.drawShadow() }

	let contentView = NewsContentView()

	let imageView = UIImageView()
		|> \.contentMode .~ .scaleAspectFill
		|> \.clipsToBounds .~ true

	let navigationBar = UINavigationBar()
		|> \.isTranslucent .~ true
		|> sideEffect { $0.setBackgroundImage(UIImage(), for: .default) }
		|> \.items .~ [.init(title: "Title")]

	let blurView = UIVisualEffectView(
		effect: UIBlurEffect(style: .systemMaterial)
	)

	override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension NewsView {
	func setup() {
		clipsToBounds = false
		backgroundColor = .systemBackground
		rootScrollView.delegate = self

		[imageView, rootScrollView, infoStackView, blurView, navigationBar].enumerated().forEach {
			$0.element.translatesAutoresizingMaskIntoConstraints = false
			insertSubview($0.element, at: $0.offset)
		}
		contentView.translatesAutoresizingMaskIntoConstraints = false
		rootScrollView.addSubview(contentView)
		addLayoutGuide(animatableBannerLayout)
		rootScrollView.contentInset = UIEdgeInsets(top: bannerHeight, left: 0, bottom: 0, right: 0)
		heightBannerConstraint = animatableBannerLayout.heightAnchor.constraint(equalToConstant: bannerHeight)

		NSLayoutConstraint.activate([
			blurView.topAnchor.constraint(equalTo: topAnchor),
			blurView.leftAnchor.constraint(equalTo: leftAnchor),
			blurView.rightAnchor.constraint(equalTo: rightAnchor),
			blurView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),

			navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			navigationBar.leftAnchor.constraint(equalTo: leftAnchor),
			navigationBar.rightAnchor.constraint(equalTo: rightAnchor),

			heightBannerConstraint,
			animatableBannerLayout.topAnchor.constraint(equalTo: topAnchor),
			animatableBannerLayout.leftAnchor.constraint(equalTo: leftAnchor),
			animatableBannerLayout.rightAnchor.constraint(equalTo: rightAnchor),

			imageView.topAnchor.constraint(equalTo: animatableBannerLayout.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: animatableBannerLayout.bottomAnchor),
			imageView.leftAnchor.constraint(equalTo: animatableBannerLayout.leftAnchor),
			imageView.rightAnchor.constraint(equalTo: animatableBannerLayout.rightAnchor),

			infoStackView.bottomAnchor.constraint(equalTo: animatableBannerLayout.bottomAnchor, constant: -10),
			infoStackView.leftAnchor.constraint(equalTo: animatableBannerLayout.leftAnchor, constant: 20),
			infoStackView.topAnchor.constraint(greaterThanOrEqualTo: animatableBannerLayout.topAnchor),
			infoStackView.rightAnchor.constraint(equalTo: animatableBannerLayout.rightAnchor),

			rootScrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: rootScrollView.frameLayoutGuide.widthAnchor),

			rootScrollView.contentLayoutGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
			rootScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			rootScrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			rootScrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: contentView.rightAnchor),

			rootScrollView.topAnchor.constraint(equalTo: topAnchor),
			rootScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			rootScrollView.leftAnchor.constraint(equalTo: leftAnchor),
			rootScrollView.rightAnchor.constraint(equalTo: rightAnchor)
		])
	}
}

extension NewsView: UIScrollViewDelegate {
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		heightBannerConstraint.constant = max(-scrollView.contentOffset.y, 0)

		let scale = pow(
			max(
				min(
					-scrollView.contentOffset.y / bannerHeight,
					1), 0), 2)

		imageView.alpha = scale
		blurView.alpha = 1 - scale
		navigationBar.alpha = 1 - scale
		titleLabel.alpha = scale
	}
}

private extension NewsView {
	var bannerHeight: CGFloat {
		return UIApplication.shared.windows.first(where: { $0.isKeyWindow })!.screen.bounds.height / 3
	}
}

private extension UIView {
	func drawShadow() {
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowRadius = 3.0
		self.layer.shadowOpacity = 1.0
		self.layer.shadowOffset = CGSize(width: 4, height: 4)
		self.layer.masksToBounds = false
	}
}
