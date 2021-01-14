//
//  EventViewController.swift
//   
//
//  Created by user on 05/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import DesignEngine
import AppFoundation
import Platform
import RxSwift

public class EventsListViewController: BaseViewController<UITableView, EventsListFlow> {

	fileprivate let sharedDescriptionTap = PublishSubject<IndexPath>()
	fileprivate let pullToRefresh = PublishSubject<Void>()
	private var dataSource: UITableViewDiffableDataSource<OnceSection, EventsListFlow.CellItem>!
	private let refreshControl = UIRefreshControl()

	public override init(viewModel: BaseViewModel<EventsListFlow>) {
		super.init(viewModel: viewModel)

		tabBarItem = UITabBarItem(
			title: "Events",
			image: UIImage(systemName: "square.and.arrow.down"),
			selectedImage: nil
		)

		navigationItem.title = "Today"

		refreshControl.addTarget(self, action: #selector(pullToRefreshHandler), for: .valueChanged)
		tableView.refreshControl = refreshControl
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override var input: Input {
		return Input(
			descriptionDidTap: sharedDescriptionTap.map { $0.row }.asObservable(),
			pullToRefresh: pullToRefresh.asObserver()
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

		output.downloadedData
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { [weak refreshControl] in
				refreshControl?.endRefreshing()
			})
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

extension EventsListViewController {
	@objc func pullToRefreshHandler() {
		pullToRefresh.on()
	}
}

extension EventsListViewController: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
