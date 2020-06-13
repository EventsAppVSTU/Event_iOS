//
//  ScreenBuilder.swift
//  Logic
//
//  Created by Araik Garibian on 5/30/20.
//

import UIKit
import Library
import Views


public class ScreenBuilder {
	public static func getMainScreen(context: GlobalContext) -> UIViewController {
		let mainViewController = UITabBarController()
		mainViewController.navigationItem.largeTitleDisplayMode = .always
		mainViewController.viewControllers = [
			getEventsListScreen(context: context),
			getSettingsScreen(context: context),
			getNewsScreen()
		]
		mainViewController.tabBar.tintColor = .systemRed
		
		return mainViewController
	}
	
	public static func getEventsListScreen(context: GlobalContext) -> UIViewController {
		let viewModel = EventsListViewModel(globalContext: context)
		let screen = EventsListViewController(viewModel: viewModel)
		
		let eventNavigationController = UINavigationController(rootViewController: screen)
		eventNavigationController.navigationBar.prefersLargeTitles = true
		
		return eventNavigationController
	}
	
	public static func getSettingsScreen(context: GlobalContext) -> UIViewController {
		let viewModel = SettingsViewModel()
		return SettingsViewController(viewModel: viewModel)
	}
	
	public static func getNewsScreen() -> UIViewController {
		let viewModel = NewsViewModel()
		return NewsViewController(viewModel: viewModel)
	}
}
