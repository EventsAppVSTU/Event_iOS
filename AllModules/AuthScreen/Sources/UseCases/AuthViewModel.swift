//
//  AuthViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 5/30/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import RxSwift
import AppFoundation
import Platform
import DesignEngine
import RegistrationScreen
import Services

public class AuthViewModel: BaseViewModel<AuthFlow> {
    private let navigationController: UINavigationController
    private let authorizationService: AuthorizationServiceProtocol
    private let authorizationStore: AuthorizationStoreProtocol
    private let alertCenter: AlertCenterProtocol
    private let mainScreenRouter: AnyRouter<MainScreenRouter>
    private let registrationScreenRouter: AnyRouter<MainScreenRouter>

	public init(
        navigationController: UINavigationController,
        authorizationService: AuthorizationServiceProtocol,
        authorizationStore: AuthorizationStoreProtocol,
        alertCenter: AlertCenterProtocol,
        mainScreenRouter: AnyRouter<MainScreenRouter>,
        registrationScreenRouter: AnyRouter<MainScreenRouter>
    ) {
		self.navigationController = navigationController
        self.authorizationService = authorizationService
        self.authorizationStore = authorizationStore
        self.alertCenter = alertCenter
        self.mainScreenRouter = mainScreenRouter
        self.registrationScreenRouter = registrationScreenRouter

		super.init()
	}

    public init(container: Container) throws {
        self.navigationController = try container.resolve()
        self.authorizationService = try container.resolve()
        self.authorizationStore = try container.resolve()
        self.alertCenter = try container.resolve()
        self.mainScreenRouter = try container.resolve()
        self.registrationScreenRouter = try container.resolve()

        super.init()
    }

	private var serverResponse = PublishSubject<String>()

	public override func transform(input: AuthFlow.Input, bag: DisposeBag) -> AuthFlow.Output {
		let credential = Observable
			.combineLatest(input.email, input.password)
			.observe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .utility)))
            .map(Authorization.Credentials.init)

        input.loginButton
            .withLatestFrom(credential)
            .observe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .utility)))
            .flatMap(authorizationService.authorize)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: handleResponse)
            .disposed(by: bag)

		input.registrationButton
			.observe(on: MainScheduler.instance)
            .subscribe(onNext: registrationScreenRouter.show)
			.disposed(by: bag)

        return AuthFlow.Output.empty
	}
}

private extension AuthViewModel {
    func handleResponse(_ container: Result<Authorization.ResponseBody, Error>) {
        switch container {
        case let .success(body):
            authorizationStore.authorize(token: body.token)
            mainScreenRouter.show()
        case let .failure(error):
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            alertCenter.alert(title: "Error", description: error.localizedDescription)
        }
    }
}
