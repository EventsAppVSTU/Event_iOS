//
//  Optional+Rx.swift
//  AppFoundation
//
//  Created by Metalluxx on 21.04.2021.
//

import RxSwift

public extension Optional {
    func toObservable() -> Observable<Self> {
        Observable.create { (observer) -> Disposable in
            observer.on(.next(self))
            observer.on(.completed)

            return Disposables.create()
        }
    }

    func toObservable(error: Error) -> Observable<Wrapped> {
        Observable.create { (observer) -> Disposable in
            switch self {
            case let .some(object):
                observer.onNext(object)
            case .none:
                observer.onError(error)
            }

            return Disposables.create()
        }
    }
}
