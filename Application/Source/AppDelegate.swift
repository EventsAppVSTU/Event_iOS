//
//  AppDelegate.swift
//   
//
//  Created by user on 04/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Platform
import AuthScreen
import NewNetworking

public private(set) var globalNavigationController: UINavigationController!

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	var navigationController: UINavigationController!

    func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
		-> Bool {
		globalNavigationController = UINavigationController()
		globalNavigationController.setNavigationBarHidden(true, animated: false)
		globalNavigationController.navigationBar.prefersLargeTitles = true

		let globalContext = GlobalContext(
			globalNavigationController: globalNavigationController
		)

		let viewModel = AuthViewModel(globalContext: globalContext)
		let viewController = AuthViewController(viewModel: viewModel)
		globalNavigationController.viewControllers = [viewController]

		let window = UIWindow()
        window.rootViewController = globalNavigationController
        window.makeKeyAndVisible()
        self.window = window

		globalNavigationController.interactivePopGestureRecognizer?.delegate = nil

        return true
    }
}
