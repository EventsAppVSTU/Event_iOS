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
import AppFoundation

private enum ContainerMarkers: String {
    case baseUrl
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var container = Container()
    var window: UIWindow?

    func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        configure(container: container)

        let body = Registration.RequestBody(
            required: .init(
                name: "Antonio",
                surname: "Banderas",
                login: "Chiljjintano2",
                password: "Pasta233"
            ),
            optional: .init(
                phone: "89999999999",
                webLink: "www.swift.org",
                bio: "AHAHAHHAHA",
                organizationVerify: 20
            )
        )

        let s = (try! container.resolve() as RegistrationServiceProtocol)
            .sendRegistrationRequest(body)
            .share()
            .subscribe {
                print("ada \($0)")
            }

        let authorizationStore: AuthorizationStoreProtocol = try! container.resolve()

        let navigationController: UINavigationController = try! container.resolve()
		navigationController.viewControllers = []

		let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window

		navigationController.interactivePopGestureRecognizer?.delegate = nil

        if authorizationStore.getToken() != nil {
            let mainScreen: AnyRouter<MainScreenRouter> = try! container.resolve()
            mainScreen.show()
        } else {
            let viewModel = try! AuthViewModel(container: container)
            let viewController = AuthViewController(viewModel: viewModel)

            navigationController.pushViewController(viewController, animated: true)
        }

        return true
    }
}

private extension AppDelegate {
    func configure(container: Container) {
        container.register(UINavigationController.self, scope: .shared) { _ in
            let navigationController = UINavigationController()
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.navigationBar.prefersLargeTitles = true
            return navigationController
        }

        container.register(JSONEncoder.self, scope: .shared) { _ in
            let enc = JSONEncoder()
            enc.keyEncodingStrategy = .convertToSnakeCase
            return enc
        }

        container.register(JSONDecoder.self, scope: .shared) { _ in
            let dec = JSONDecoder()
            dec.keyDecodingStrategy = .convertFromSnakeCase
            return dec
        }

        container.register(HTTPLoadingBuilder.self, scope: .shared) {
            _ in {
                makeChains {
                    Loader.Print()
                    Loader.URLSession()
                }
            }
        }

        container.registerMarker(String.self, marker: ContainerMarkers.baseUrl) { _ in
            "http://www.yaem.store/"
        }

        try! container.register(AuthorizationServiceProtocol.self) { container in
            return Authorization.Service(
                loader: try container.resolve(),
                baseURL: try container.resolveMarker(marker: ContainerMarkers.baseUrl),
                decoder: try container.resolve(),
                encoder: try container.resolve()
            )
        }

        container.register(AuthorizationStoreProtocol.self) { _ in
            Authorization.Store(userDefaults: .standard)
        }

        try! container.register(AlertCenterProtocol.self) { container in
            AlertCenter(navigarionController: try container.resolve())
        }

        try! container.register(OrganizationsServiceProtocol.self) { container in
            return Organizations.Service(
                loader: try container.resolve(),
                baseURL: try container.resolveMarker(marker: ContainerMarkers.baseUrl),
                decoder: try container.resolve(),
                encoder: try container.resolve()
            )
        }

        try! container.register(RegistrationServiceProtocol.self) { container in
            return Registration.Service(
                loader: try container.resolve(),
                baseURL: try container.resolveMarker(marker: ContainerMarkers.baseUrl),
                decoder: try container.resolve(),
                encoder: try container.resolve()
            )
        }

        try! container.register(EventsServiceProtocol.self) { container in
            Events.Service(
                loader: try container.resolve(),
                baseURL: try container.resolveMarker(marker: ContainerMarkers.baseUrl),
                decoder: try container.resolve(),
                encoder: try container.resolve(),
                authorizationStore: try container.resolve()
            )
        }

        container.register(AnyRouter<MainScreenRouter>.self) { container in
            AnyRouter(MainScreenRouter(container: container))
        }

        container.register(AnyRouter<RegistrationScreenRouter>.self) { container in
            AnyRouter(RegistrationScreenRouter(container: container))
        }

    }
}


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
// , alertCenter: <#AlertCenterProtocol#>           baseURL: "http://www.yaem.store/",
//            decoder: globalContext.decoder,
//            encoder: globalContext.encoder
//        )
//        .sendRegistrationRequest(body)
//        .share()
//        .subscribe {
//            print($0)
//        }
//        let k = authService
//            .authorize(.init(login: "Chilintano2", password: "Pasta233"))
//            .share()
//            .subscribe { print($0) }
//
//
//let sss = (try! container.resolve() as OrganizationsServiceProtocol)
//    .getOrganizations()
//    .subscribe(onNext: {
//        print("saske \($0)")
//    })
