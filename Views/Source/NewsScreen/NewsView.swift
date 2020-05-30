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
	let tableView = UITableView()
	let imageView = UIImageView()
	let navigationBar = UINavigationBar()
	
	let blurView = UIVisualEffectView(
		effect: UIBlurEffect(style: .systemMaterial)
	)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		navigationBar.isTranslucent = true
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.items = [.init(title: "HUETA")]
		
		backgroundColor = .systemBackground
		imageView.image = UIImage(named: "kremlin")
		imageView.contentMode = .scaleAspectFill
		tableView.delegate = self
		tableView.backgroundColor = .clear
		
		[imageView, tableView, blurView, navigationBar].enumerated().forEach {
			$0.element.translatesAutoresizingMaskIntoConstraints = false
			insertSubview($0.element, at: $0.offset)
		}
		addLayoutGuide(animatableBannerLayout)
		
		heightBannerConstraint = animatableBannerLayout.heightAnchor.constraint(equalToConstant: bannerHeight)
		tableView.contentInset = UIEdgeInsets(top: bannerHeight, left: 0, bottom: 0, right: 0)
		
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
			
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension NewsView: UITableViewDelegate {
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		heightBannerConstraint.constant = max(-scrollView.contentOffset.y, 0)
		
		let scale = pow(
			max(
				min(
					-scrollView.contentOffset.y / bannerHeight,
					1)
				, 0)
			, 2)
		
		imageView.alpha = scale
		blurView.alpha = 1 - scale
		navigationBar.alpha = 1 - scale
	}
}

fileprivate extension NewsView {
	var bannerHeight: CGFloat {
		return 300
	}
}
