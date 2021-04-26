//
//  RegistrationScreenRouter.swift
//  AuthScreen
//
//  Created by Metalluxx on 28.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

import DesignEngine
import Platform
import AppFoundation
import RegistrationScreen

public struct RegistrationScreenRouter {
    private let container: Container

    public init(container: Container) {
        self.container = container
    }
}

extension RegistrationScreenRouter: ScreenRouterProtocol {
    public typealias Arg = Void

    public func show(_ arg: Void) {
        let navigationController: UINavigationController = try! container.resolve()

        let closure: () -> Void = { [navigationController] in
            navigationController.popViewController(animated: true)
        }

        let viewModel = try! RegistrationViewModel(
            backClosure: closure,
            container: container
        )

        navigationController.pushViewController(
            RegistrationViewController(viewModel: viewModel),
            animated: true
        )
    }
}
