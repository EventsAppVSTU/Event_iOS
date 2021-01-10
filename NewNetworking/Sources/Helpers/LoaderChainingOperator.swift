//
//  LoaderChainingOperator.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/20/20.
//

precedencegroup LoaderChainingPrecedence {
	higherThan: NilCoalescingPrecedence
	associativity: right
}

infix operator --> : LoaderChainingPrecedence

@discardableResult
public func --> (lhs: HTTPLoading?, rhs: HTTPLoading?) -> HTTPLoading? {
	lhs?.nextLoader = rhs
	return lhs ?? rhs
}
