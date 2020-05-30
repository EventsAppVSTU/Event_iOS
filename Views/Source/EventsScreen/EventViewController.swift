//
//  EventViewController.swift
//   
//
//  Created by user on 05/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

public class EventViewController: UITableViewController {

	public required init() {
		super.init(nibName: nil, bundle: nil)
		
		tabBarItem = UITabBarItem(title: "Events",
								  image: UIImage(systemName: "square.and.arrow.down"),
								  selectedImage: nil)
		
		navigationItem.title = "Today"
	}
	
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private var dataSource: UITableViewDiffableDataSource<OnceSection, EventItem>!
	
    public override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "cell")
		
		dataSource = .init(tableView: tableView)
		{ (tv, ip, item) -> UITableViewCell? in
			let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! EventTableViewCell
			
			cell.titleLabel.text = item.titleText
			cell.descriptionLabel.text = item.descriptionText
			cell.newsImageView.image = item.image
			cell.dateLabel.text = item.date
			
			return cell
		}
		
		var snapshot = NSDiffableDataSourceSnapshot<OnceSection, EventItem>()
		snapshot.appendSections([.main])
		snapshot.appendItems([
			EventItem(titleText: "Кремль и кококкоронавирус",
					  descriptionText: "Вчера провели конференцию в сарае с лидерами общественного мнения среди сообщества WAG и обсудили актуальные проблемы общества: кризис малого производства пивных напитков и мехатроников для DSG",
					  date: "Вроде вчера это было",
					  image: UIImage(named: "kremlin")
			)
		])
		dataSource.apply(snapshot)
    }
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

}
