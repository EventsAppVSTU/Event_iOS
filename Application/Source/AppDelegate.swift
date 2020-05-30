//
//  AppDelegate.swift
//   
//
//  Created by user on 04/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Logic
import Views
import Library

public private(set) var globalNavigationController: UINavigationController!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
	var navigationController: UINavigationController!
	
    func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
		-> Bool
	{
		let viewModel = AuthViewModel()
		let vc = AuthViewController(viewModel)
		
		globalNavigationController = UINavigationController(rootViewController: vc)
		globalNavigationController.setNavigationBarHidden(true, animated: false)
		globalNavigationController.navigationBar.prefersLargeTitles = true
        
		let window = UIWindow()
        window.rootViewController = globalNavigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

extension UIApplication {
	var appDelegate: AppDelegate! {
		return delegate as? AppDelegate
	}
}
