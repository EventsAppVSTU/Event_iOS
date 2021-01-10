//
//  EventViewController.swift
//   
//
//  Created by user on 05/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Library
import Flow
import RxSwift

public class EventsListViewController: BaseViewController<UITableView, EventsListFlow> {

	fileprivate let sharedDescriptionTap = PublishSubject<IndexPath>()
	private var dataSource: UITableViewDiffableDataSource<OnceSection, EventsListFlow.CellItem>!

	public override func afterInit() {
		tabBarItem = UITabBarItem(
			title: "Events",
			image: UIImage(systemName: "square.and.arrow.down"),
			selectedImage: nil
		)

		navigationItem.title = "Today"
	}

	public override var input: Input {
		return Input(
			descriptionDidTap: sharedDescriptionTap.map { $0.row }.asObservable()
		)
	}

	public override func bind(output: EventsListFlow.Output) {
		Observable
			.combineLatest(output.listData, didLoadObservable)
			.map(\.0)
			.observe(on: MainScheduler.instance)
			.map {
				var snapshot = NSDiffableDataSourceSnapshot<OnceSection, EventsListFlow.CellItem>()
				snapshot.appendSections([.main])
				snapshot.appendItems($0)
				return snapshot
			}
			.subscribe(
				onNext: unowned(dataSource) { $0.apply($1) }
			)
			.disposed(by: bag)
	}

	public override func didLoad() {
		tableView.register(
			EventTableViewCell.self,
			forCellReuseIdentifier: String(describing: EventTableViewCell.self)
		)

		tableView.automaticallyAdjustsScrollIndicatorInsets = true
		tableView.delegate = self
		tableView.allowsSelection = false

		dataSource = .init(tableView: tableView) { [unowned self] tableView, indexPath, item -> UITableViewCell? in
			let identifier = String(describing: EventTableViewCell.self)
			
			guard
				let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? EventTableViewCell
			else { return nil }

			cell.currentIndexPath = indexPath
			cell.titleLabel.text = item.titleText
			cell.descriptionLabel.text = item.descriptionText
			cell.newsImageView.set(image: item.image)
			cell.dateLabel.text = item.date
			cell.connectDescriptionTap(to: self.sharedDescriptionTap)

			return cell
		}
	}
}

extension EventsListViewController: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
