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
import Services

public private(set) var globalNavigationController: UINavigationController!

struct GlobalContextFactory {
    static func make(navigationController: UINavigationController) -> GlobalContext {
        let hueta = JSONEncoder()
        let pizdec = JSONDecoder()

        hueta.keyEncodingStrategy = .convertToSnakeCase
        pizdec.keyDecodingStrategy = .convertFromSnakeCase

        let makeLoader = {
            makeChains {
                Loader.ModifyRequest { $0.headers["Authorization"] = "1 111111_2" }
                Loader.Print()
                Loader.URLSession()
            }
        }

        return GlobalContext(
            globalNavigationController: navigationController,
            makeLoader: makeLoader,
            decoder: pizdec,
            encoder: hueta
        )
    }
}

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

        let globalContext = GlobalContextFactory.make(navigationController: globalNavigationController)

//        let body = Registration.RequestBody(
//            required: .init(
//                name: "Antonio",
//                surname: "Banderas",
//                login: "Chilintano2",
//                password: "Pasta233"
//            ),
//            optional: .init(
//                phone: "89999999999",
//                webLink: "www.swift.org",
//                bio: "AHAHAHHAHA",
//                organizationVerify: 20
//            )
//        )


//        let s = Services.Registration.Service(
//            loader: globalContext.makeLoader,
//            baseURL: "http://www.yaem.store/",
//            decoder: globalContext.decoder,
//            encoder: globalContext.encoder
//        )
//        .sendRegistrationRequest(body)
//        .share()
//        .subscribe {
//            print($0)
//        }

        let k = Services.Authorization.Service(
            loader: globalContext.makeLoader,
            baseURL: "http://www.yaem.store/",
            decoder: globalContext.decoder,
            encoder: globalContext.encoder
        )
        .authorize(.init(login: "Chilintano2", password: "Pasta233"))
        .share()
        .subscribe { print($0) }

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
