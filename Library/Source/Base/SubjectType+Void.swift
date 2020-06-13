//
//  SubjectType+Void.swift
//  Library
//
//  Created by Araik Garibian on 6/12/20.
//

import RxSwift

public extension ObserverType where Element == Void {
	func on() {
		self.on(
			.next( () )
		)
	}
}

