//
//  MainScreenBuilder.swift
//  AuthScreen
//
//  Created by Araik Garibian on 11.01.2021.
//

import Platform
import DesignEngine
import EventsScreen
import SettingsScreen

func getMainScreen(context: GlobalContext) -> UIViewController {
	let mainViewController = UITabBarController()
	mainViewController.navigationItem.largeTitleDisplayMode = .always
	mainViewController.viewControllers = [
		getEventsListScreen(context: context),
		getSettingsScreen(context: context)
	]
	mainViewController.tabBar.tintColor = .systemRed

	return mainViewController
}

func getEventsListScreen(context: GlobalContext) -> UIViewController {
	let viewModel = EventsListViewModel(globalContext: context)
	let screen = EventsListViewController(viewModel: viewModel)

	let eventNavigationController = UINavigationController(rootViewController: screen)
	eventNavigationController.navigationBar.prefersLargeTitles = true

	return eventNavigationController
}

func getSettingsScreen(context: GlobalContext) -> UIViewController {
	let viewModel = SettingsViewModel()
	return SettingsViewController(viewModel: viewModel)
}
