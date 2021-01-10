//
//  SettingsViewController.swift
//  Events
//
//  Created by Araik Garibian on 5/24/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Kingfisher
import Library
import Flow
import RxSwift

public class SettingsViewController: BaseViewController<SettingsView, SettingsFlow> {

	typealias UniqueItem = Unique<SettingsFlow.CellItems>

	fileprivate let didTapSubject = PublishSubject<Int>()
	private var dataSource: UITableViewDiffableDataSource<OnceSection, UniqueItem>!

	public override func afterInit() {
		tabBarItem = UITabBarItem(
			title: "Settings",
			image: UIImage(systemName: "multiply.circle.fill"),
			selectedImage: nil
		)
	}

	public override var input: SettingsFlow.Input {
		return Input(
			didTap: didTapSubject.asObserver()
		)
	}

	public override func bind(output: SettingsFlow.Output) {
		Observable
			.combineLatest(output.personInfo, didLoadObservable)
			.map { $0.0 }
			.subscribe(
				onNext: unowned(contentView) { instance, arg in
					instance.personNameLabel.text = arg.name
					instance.personAvatarView.set(image: arg.avatar)
				}
			)
			.disposed(by: bag)

		Observable
			.combineLatest(output.listData, didLoadObservable)
			.map { tuple -> NSDiffableDataSourceSnapshot<OnceSection, UniqueItem> in
				let value = tuple.0
				var snapshot = NSDiffableDataSourceSnapshot<OnceSection, UniqueItem>()
				snapshot.appendSections([.main])
				snapshot.appendItems(value.map { Unique($0) })
				return snapshot
			}
			.subscribe(
				onNext: unowned(dataSource) {
					$0.apply($1)
				}
			)
			.disposed(by: bag)
	}

	public override func didLoad() {
		contentView.tableView.separatorStyle = .none
		contentView.tableView.allowsSelection = true

		contentView.tableView.delegate = self

		contentView.tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.ReuseID)
		contentView.tableView.register(SimpleCell.self, forCellReuseIdentifier: SimpleCell.ReuseID)
		contentView.tableView.register(DividerTableViewCell.self, forCellReuseIdentifier: DividerTableViewCell.ReuseID)

		dataSource = .init(tableView: contentView.tableView) { tableView, _, uniqueItem -> UITableViewCell? in
			let item = uniqueItem.value
			switch item {
			case .divider:
				return tableView.cell(type: DividerTableViewCell.self) {
					$0.dividerColor = .systemGray6
				}
			case .emptyPlace:
				return tableView.cell(type: EmptyTableViewCell.self) {
					$0.cellHeight = 20
				}
			case .item(let item):
				return tableView.cell(type: SimpleCell.self) {
					$0.leftIconView.set(image: item.icon)
					$0.rightIconView.set(image: item.secondaryIcon)
					$0.titleLabel.text = item.name
				}
			}
		}
	}
}

private extension UITableView {
	func cell<Cell: UITableViewCell>(
		type: Cell.Type,
		identifier: String = Cell.ReuseID,
		_ setupCellClosure: (Cell) -> Void
	) -> Cell? {
		guard
			let cell = dequeueReusableCell(withIdentifier: Cell.ReuseID) as? Cell
		else {
			return nil
		}

		setupCellClosure(cell)

		return cell
	}
}

extension SettingsViewController: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		didTapSubject.onNext(indexPath.row)
		tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
	}

	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
