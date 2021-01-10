//
//  HTTPLoading.Rx.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/29/20.
//

import Foundation
import RxSwift

public extension HTTPLoading {
	func load(request: HTTP.Request) -> Observable<HTTP.Result> {
		.create { (observer: AnyObserver<HTTP.Result>) -> Disposable in
			let task = HTTP.Task(request: request) {
				observer.onNext($0)
				observer.onCompleted()
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
