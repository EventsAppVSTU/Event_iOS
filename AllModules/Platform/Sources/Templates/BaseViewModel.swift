//
//  BaseViewModel.swift
//  Library
//
//  Created by Araik Garibian on 5/30/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import RxSwift

open class BaseViewModel<Flow: FlowProtocol>: ViewModelTemplate {
	public typealias Input = Flow.Input
	public typealias Output = Flow.Output
	public typealias Flow = Flow

	public init() {}

	open func transform(input: Flow.Input, bag: DisposeBag) -> Flow.Output {
		fatalError("You did not override the transform method for type \(type(of: self))")
	}
}
