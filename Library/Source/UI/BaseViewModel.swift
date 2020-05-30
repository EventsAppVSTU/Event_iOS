//
//  BaseViewModel.swift
//  Library
//
//  Created by Araik Garibian on 5/30/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import Combine

open class BaseViewModel<Flow: FlowProtocol>: ViewModelTemplate {
	public typealias Input = Flow.Input
	public typealias Output = Flow.Output
	public typealias Flow = Flow
	
	public init() {}
	
	open func transform(input: Flow.Input, bag: inout Set<AnyCancellable>) -> Flow.Output {
		fatalError("You did not override the transform method for type \(type(of: self))")
	}
}
