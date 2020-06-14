//
//  DefaultGateway+Rx.swift
//  ApplicationCore
//
//  Created by Metalluxx on 06/10/2019.
//  Copyright © 2019 Metallixx. All rights reserved.
//

import Foundation
import RxSwift


extension Gateway: ReactiveCompatible {}


extension Reactive where Base: ReactiveCompatible & RequestExecutable {
    public func dataRequest(_ route: RequestStructure) -> ResponseObservable<Data> {
        ResponseObservable<Data>.create {
			(event) -> Disposable in
				
            weak var task = self.base.dataRequest(route) {
				(result) in
                event.onNext(result)
                event.onCompleted()
            }
				
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}

public extension Reactive where Base: ReactiveCompatible & ObjectRequestExecutable {
    func objectRequest<ResponseObject: Decodable>(_ route: RequestStructure, objectType: ResponseObject.Type) -> ResponseObservable<ResponseObject>
    {
        ResponseObservable<ResponseObject>.create {
			(event) -> Disposable in
			
            weak var task = self.base.objectRequest(route, objectType: ResponseObject.self) {
				(result) in
                event.onNext(result)
                event.onCompleted()
            }
			
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
