//
//  Optional+Rx.swift
//  AppFoundation
//
//  Created by Metalluxx on 21.04.2021.
//

import RxSwift

public extension ObservableType {
    func mapToResult<R>(
        _ transform: @escaping (Self.Element) throws -> R
    ) -> RxSwift.Observable<Result<R, Error>> {
        self.map {
            do {
                let result = try transform($0)
                return .success(result)
            }
            catch {
                return .failure(error)
            }
        }
    }
}

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
