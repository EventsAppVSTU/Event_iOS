//
//  BaseViewController.swift
//  Library
//
//  Created by Araik Garibian on 5/29/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import UIKit
import Combine

open class BaseViewController<View: UIView, Flow: FlowProtocol>
: ContentViewController<View>, CancellableContainer, ViewControllerTemplate
{
	public typealias Input = Flow.Input
	public typealias Output = Flow.Output
	public typealias Flow = Flow
	
	open var input: Flow.Input {
		fatalError()
	}
	
	open func bind(output: Flow.Output) {
		fatalError()
	}

	
    public var store = Set<AnyCancellable>()
	
	public let viewModel: BaseViewModel<Flow>

    // MARK: Init
    public init(_ viewModel: BaseViewModel<Flow>) {
        self.viewModel = viewModel
        super.init()
    }
	
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
