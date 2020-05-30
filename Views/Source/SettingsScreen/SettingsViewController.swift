//
//  SettingsViewController.swift
//  Events
//
//  Created by Araik Garibian on 5/24/20.
//  Copyright © 2020 user. All rights reserved.
//

//import UIKit
//import Kingfisher
//import Library
//
//
//
//public enum SettingsItems: Hashable {
//	indirect case divider(color: UIColor)
//	case empty(height: CGFloat)
//	case simpleCell(item: SimpleCellItem)
//}
//
//public struct SettingsItemsBox: Hashable {
//	public let id = UUID()
//	public let item: SettingsItems
//	
//	public init(_ item: SettingsItems) {
//		self.item = item
//	}
//}
//
//public class SettingsViewController: BaseViewController<SettingsView> {
//	
//	private var dataSource: UITableViewDiffableDataSource<OnceSection, SettingsItemsBox>!
//	
//	public required init() {
//		super.init(nibName: nil, bundle: nil)
//		
//		tabBarItem = UITabBarItem(title: "Settings",
//								  image: UIImage(systemName: "multiply.circle.fill"),
//								  selectedImage: nil)
//	}
//	
//	public override func viewDidLoad() {
//		super.viewDidLoad()
//		
//		contentView.personAvatarView.set(image: .asset(name: "kremlin"))
//		contentView.tableView.separatorStyle = .none
//		contentView.tableView.allowsSelection = false
//		
//		contentView.tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.ReuseID)
//		contentView.tableView.register(SimpleCell.self, forCellReuseIdentifier: SimpleCell.ReuseID)
//		contentView.tableView.register(DividerTableViewCell.self, forCellReuseIdentifier: DividerTableViewCell.ReuseID)
//		
//		dataSource = .init(tableView: contentView.tableView)
//		{ (tv, ip, itemBox) -> UITableViewCell? in
//			let item = itemBox.item
//			switch item {
//			case .divider(let color):
//				let cell = tv.dequeueReusableCell(withIdentifier: DividerTableViewCell.ReuseID) as! DividerTableViewCell
//				cell.dividerColor = color
//				return cell
//			case .empty(let height):
//				let cell = tv.dequeueReusableCell(withIdentifier: EmptyTableViewCell.ReuseID) as! EmptyTableViewCell
//				cell.cellHeight = height
//				return cell
//			case .simpleCell(let item):
//				let cell = tv.dequeueReusableCell(withIdentifier: SimpleCell.ReuseID) as! SimpleCell
//				cell.leftIconView.set(image: item.leftImage)
//				cell.rightIconView.set(image: item.rightImage)
//				cell.titleLabel.text = item.title
//				return cell
//			}
//		}
//		
//		var snapshot = NSDiffableDataSourceSnapshot<OnceSection, SettingsItemsBox>()
//		snapshot.appendSections([.main])
//		snapshot.appendItems([
//			SettingsItemsBox(.divider(color: .systemGray6)),
//			SettingsItemsBox(
//				.simpleCell(item: SimpleCellItem(
//					title: "KOKO",
//					leftImage: .system(name: "square.and.arrow.down"),
//					rightImage: .system(name: "multiply.circle.fill")
//					)
//				)
//			),
//			SettingsItemsBox(.divider(color: .systemGray6)),
//			SettingsItemsBox(
//				.empty(height: 60)
//			),
//			SettingsItemsBox(.divider(color: .systemGray6)),
//			SettingsItemsBox(
//				.simpleCell(item: SimpleCellItem(
//					title: "KOKO",
//					leftImage: .system(name: "square.and.arrow.down"),
//					rightImage: .system(name: "multiply.circle.fill")
//					)
//				)
//			),
//			SettingsItemsBox(.divider(color: .systemGray6)),
//			SettingsItemsBox(
//				.empty(height: 20)
//			),
//			SettingsItemsBox(.divider(color: .systemGray6)),
//			SettingsItemsBox(
//				.simpleCell(item: SimpleCellItem(
//					title: "KOKO",
//					leftImage: .system(name: "square.and.arrow.down"),
//					rightImage: .system(name: "multiply.circle.fill")
//					)
//				)
//			),
//			SettingsItemsBox(.divider(color: .systemGray6)),
//		])
//		
//		dataSource.apply(snapshot)
//	}
//	
//	public required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//	
//}
