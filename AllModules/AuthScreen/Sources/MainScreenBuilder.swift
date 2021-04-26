//
//  MainScreenBuilder.swift
//  AuthScreen
//
//  Created by Araik Garibian on 11.01.2021.
//

import Platform
import DesignEngine
import Services
import AppFoundation
import EventsScreen
import SettingsScreen


public struct MainScreenRouter {
    private let container: Container

    public init(container: Container) {
        self.container = container
    }
}

extension MainScreenRouter: ScreenRouterProtocol {
    public typealias Arg = Void

    public func show(_ arg: Void) {
        let navCtr: UINavigationController = try! container.resolve()
        let vc = getMainScreen(container: container)
        navCtr.pushViewController(vc, animated: true)
    }
}

private extension MainScreenRouter {
    func getMainScreen(container: Container) -> UIViewController {
        let mainViewController = UITabBarController()
        mainViewController.navigationItem.largeTitleDisplayMode = .always
        mainViewController.viewControllers = [
            getEventsListScreen(container: container),
            getSettingsScreen()
        ]
        mainViewController.tabBar.tintColor = .systemRed

        return mainViewController
    }

    func getEventsListScreen(container: Container) -> UIViewController {
        let viewModel = EventsListViewModel(
            router: NewsScreenRouter(navigationController: try! container.resolve()),
            service: try! container.resolve()
        )
        let screen = EventsListViewController(viewModel: viewModel)

        let eventNavigationController = UINavigationController(rootViewController: screen)
        eventNavigationController.navigationBar.prefersLargeTitles = true

        return eventNavigationController
    }

    func getSettingsScreen() -> UIViewController {
        let viewModel = SettingsViewModel()
        return SettingsViewController(viewModel: viewModel)
    }
}
