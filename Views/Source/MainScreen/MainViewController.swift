//
//  MainViewController.swift
//   
//
//  Created by Araik Garibian on 5/18/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		let eventNavigationController = UINavigationController(rootViewController: EventViewController())
		eventNavigationController.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
		
//		let settingsVc = SettingsViewController()
		
//        viewControllers = [eventNavigationController, settingsVc, NewsViewController()]
		
		tabBar.tintColor = .systemRed
    }
}
