//
//  HTTPLoading.Rx.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/29/20.
//

import Foundation
import RxSwift

public extension HTTPLoading {
	func load(request: HTTP.Request) -> Observable<HTTP.Response> {
		.create { (observer: AnyObserver<HTTP.Response>) -> Disposable in
			let task = HTTP.Task(request: request) {
				switch $0 {
				case .success(let response):
					observer.onNext(response)
					observer.onCompleted()
				case .failure(let error):
					observer.onError(error)
				}
			}

			self.load(task: task)

			return Disposables.create {
				guard task.state == .running else { return }
				task.cancel()
				observer.onError(HTTP.Error(code: .cancelled, request: request))
			}
		}
	}
}
