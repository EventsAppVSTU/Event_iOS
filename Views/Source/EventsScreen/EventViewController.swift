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

public class EventsListViewController: BaseViewController<UITableView, EventsListFlow> {

	private var dataSource: UITableViewDiffableDataSource<OnceSection, EventsListFlow.CellItem>!
	
	public override func afterInit() {
		tabBarItem = UITabBarItem(
			title: "Events",
			image: UIImage(systemName: "square.and.arrow.down"),
			selectedImage: nil
		)
		
		navigationItem.title = "Today"
	}
	
	public override var input: Empty {
		return .empty
	}
	
	public override func bind(output: EventsListFlow.Output) {
		output.listData
			.combineLatest(didLoadPublisher) { (list, _) in list }
			.map { listData ->  NSDiffableDataSourceSnapshot<OnceSection, EventsListFlow.CellItem> in
				var snapshot = NSDiffableDataSourceSnapshot<OnceSection, EventsListFlow.CellItem>()
				snapshot.appendSections([.main])
				snapshot.appendItems(listData)
				return snapshot
			}
			.sink(receiveValue: unowned(dataSource) {
				
				$0.apply($1)
			})
			.store(in: &bag)
	}
	
	public override func didLoad() {
		tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "cell")
		
		tableView.automaticallyAdjustsScrollIndicatorInsets = true
		
		dataSource = .init(tableView: tableView)
		{ (tv, ip, item) -> UITableViewCell? in
			let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! EventTableViewCell
			
			cell.titleLabel.text = item.titleText
			cell.descriptionLabel.text = item.descriptionText
			cell.newsImageView.image = item.image
			cell.dateLabel.text = item.date
			
			return cell
		}
	} 
	
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//
//		var snapshot = NSDiffableDataSourceSnapshot<OnceSection, EventUiItem>()
//		snapshot.appendSections([.main])
//		snapshot.appendItems([

//		])
//		dataSource.apply(snapshot)
//    }
}


extension EventsListViewController: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
