//
//  ServiceErrors.swift
//  Services
//
//  Created by Araik Garibian on 12.01.2021.
//

import RxSwift

enum ServiceErrors: String, Error {
	case invalidUrl
}

extension Observable {
	static func create<E>(withError error: Error) -> Observable<E> {
		.create { (observer: AnyObserver<E>) -> Disposable in
			observer.on(.error(error))

			return Disposables.create()
		}
	}
}
