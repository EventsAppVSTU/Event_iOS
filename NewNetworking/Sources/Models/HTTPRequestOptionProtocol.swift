//
//  HTTPRequestOptionProtocol.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/20/20.
//

public protocol HTTPRequestOption {
	associatedtype Value

	/// The value to use if a request does not provide a customized value
	static var defaultOptionValue: Value { get }
}
