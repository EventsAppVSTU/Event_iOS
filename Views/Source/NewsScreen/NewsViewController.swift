//
//  NewsViewController.swift
//  Events
//
//  Created by Araik Garibian on 5/26/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Library
import Flow
import RxSwift

public class NewsViewController: BaseViewController<NewsView, NewsFlow> {
	public override func afterInit() {
		tabBarItem = UITabBarItem(
			title: "Пасхалка",
			image: UIImage(systemName: "gamecontroller"),
			selectedImage: nil
		)
	}
	
	public override var input: Input {
		return Input(
			shareButtonTap: Observable<Void>.create { _ in Disposables.create() }
		)
	}
	
	public override func bind(output: NewsFlow.Output) {
		Observable
			.combineLatest(output.article, didLoadObservable)
			.map { $0.0 }
			.subscribe(
				onNext: unowned(contentView)
				{ (instance, arg) in
					instance.titleLabel.text = arg.title
					instance.contentView.descriptionLabel.text = arg.description
					instance.contentView.textLabel.text = arg.content
					instance.imageView.set(image: arg.image)
					instance.navigationBar.topItem?.title = arg.title
				}
			)
			.disposed(by: bag)
	}
}
