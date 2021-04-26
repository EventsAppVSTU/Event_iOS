//
//  RegistrationViewModel.swift
//  Logic
//
//  Created by Araik Garibian on 7/23/20.
//

import Foundation
import AppFoundation
import Platform
import RxSwift
import DesignEngine
import Services

public class RegistrationViewModel: BaseViewModel<RegistrationFlow> {
    private let backClosure: () -> Void
    private let organizationsService: OrganizationsServiceProtocol
    private let registrationService: RegistrationServiceProtocol

    private let organizations = PublishSubject<[Int: String]>()
    private let selectedOrganization = PublishSubject<Int>()

    private var localBag = DisposeBag()

    public init(
        backClosure: @escaping () -> Void,
        organizationsService: OrganizationsServiceProtocol,
        registrationService: RegistrationServiceProtocol
    ) {
        self.backClosure = backClosure
        self.organizationsService = organizationsService
        self.registrationService = registrationService
        
        super.init()

        organizationsService
            .getOrganizations()
            .map { try $0.get() }
            .map { $0.reduce(into: [Int: String]()) { res, org in
                res[org.id] = org.name
            }}
            .subscribe(organizations)
            .disposed(by: localBag)

        selectedOrganization
            .subscribe { print($0) }
            .disposed(by: localBag)
    }

    public init(
        backClosure: @escaping () -> Void,
        container: Container
    ) throws {
        self.backClosure = backClosure
        self.organizationsService = try container.resolve()
        self.registrationService = try container.resolve()

        super.init()

        organizationsService
            .getOrganizations()
            .map { try $0.get() }
            .map { $0.reduce(into: [Int: String]()) { res, org in
                res[org.id] = org.name
            }}
            .subscribe(organizations)
            .disposed(by: localBag)

        selectedOrganization
            .subscribe { print($0) }
            .disposed(by: localBag)
    }

	struct Credential {
		let login: String
		let password: String
		let name: String
		let surname: String
        let selectedOrganization: Int
        let bio: String
        let phone: String
        let link: String

        var requestBody: Registration.RequestBody {
            .init(
                required: UserDataBody(
                    name: name,
                    surname: surname,
                    image: .init(),
                    organizationId: nil,
                    currentEvent: nil,
                    login: login,
                    password: password
                ),
                optional: Registration.NestedRequestBody(
                    phone: phone,
                    webLink: link,
                    bio: bio,
                    organizationVerify: IntFromString(selectedOrganization)
                )
            )
        }
	}

	public override func transform(
        input: RegistrationFlow.Input,
        bag: DisposeBag
    ) -> RegistrationFlow.Output {
        let credentials = Observable.combineLatest(
            input.login,
            input.password,
            input.name,
            input.surname,
            input.selectedOrganization.compactMap { $0 },
            input.bio,
            input.phone,
            input.link
        )
        .map(Credential.init)
        .map(\.requestBody)

        input.registrationButton
            .withLatestFrom(credentials)
            .flatMap(registrationService.sendRegistrationRequest)
            .subscribe { print("sos \($0)") }
            .disposed(by: bag)



		input.backButton
			.subscribe(onNext: { [weak self] in
                self?.backClosure()
			})
			.disposed(by: bag)

        input.selectedOrganization
            .compactMap { $0 }
            .subscribe(selectedOrganization)
            .disposed(by: bag)

		return Output(
            organizationList: organizations.asObserver()
		)
	}
}
