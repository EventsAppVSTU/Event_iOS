//
//  RegistrationFlow.swift
//  Flow
//
//  Created by Araik Garibian on 7/23/20.
//

import Platform
import RxSwift

public enum RegistrationFlow: FlowProtocol {

	public struct Input {
        public let login: Observable<String>
        public let password: Observable<String>
		public let name: Observable<String>
		public let surname: Observable<String>
        public let registrationButton: Observable<Void>
		public let backButton: Observable<Void>
        public let phone: Observable<String>
        public let link: Observable<String>
        public let bio: Observable<String>
        public let selectedOrganization: Observable<Int?>

        public init(
            login: Observable<String>,
            password: Observable<String>,
			name: Observable<String>,
			surname: Observable<String>,
            registrationButton: Observable<Void>,
			backButton: Observable<Void>,
            selectedOrganization: Observable<Int?>,
            phone: Observable<String>,
            bio: Observable<String>,
            link: Observable<String>
		) {
            self.login = login
            self.password = password
			self.name = name
			self.surname = surname
            self.registrationButton = registrationButton
			self.backButton = backButton
            self.selectedOrganization = selectedOrganization
            self.phone = phone
            self.link = link
            self.bio = bio
        }
    }

	public struct Output {
        public let organizationList: Observable<[Int: String]>

		public init(
            organizationList: Observable<[Int: String]>
		) {
            self.organizationList = organizationList
		}
	}
}
