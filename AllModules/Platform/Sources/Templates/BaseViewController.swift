//
//  BaseViewController.swift
//  Library
//
//  Created by Araik Garibian on 5/29/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import UIKit
import AppFoundation
import RxSwift

open class BaseViewController
<View: UIView, Flow: FlowProtocol>
: ContentViewController<View>, CancellableContainer, ViewControllerTemplate
{
	public typealias Input = Flow.Input
	public typealias Output = Flow.Output
	public typealias Flow = Flow

	private let didLoadSubject = PublishSubject<Void>()
	public var didLoadObservable: Observable<Void> {
		didLoadSubject.asObserver()
	}

    public var bag = DisposeBag()
	public let viewModel: BaseViewModel<Flow>

	open var input: Flow.Input {
		fatalError("Don't have 'input' implementation in \(self)")
	}

	open func bind(output: Flow.Output) {
		fatalError("Don't have 'bind(output:)' implementation in \(self)")
	}

	open override func viewDidLoad() {
		super.viewDidLoad()

		didLoad()
		bind(output: viewModel.transform(input: self.input, bag: self.bag))
		didLoadSubject.on()
	}

	open func didLoad() {}

    public init(viewModel: BaseViewModel<Flow>) {
        self.viewModel = viewModel

        super.init()
    }

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

public extension BaseViewController where View: UITableView {
	var tableView: View! {
		return view as? View
	}
}
