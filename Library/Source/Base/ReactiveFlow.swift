//
//  ReactiveFlow.swift
//  Library
//
//  Created by Araik Garibian on 5/29/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import Foundation
import RxSwift

public protocol FlowProtocol {
	associatedtype Input
	associatedtype Output
}

public protocol ViewModelTemplate {
    associatedtype Flow: FlowProtocol
    associatedtype Input where Flow.Input == Input
    associatedtype Output where Flow.Output == Output
    func transform(input: Input, bag: DisposeBag) -> Output
}

public protocol ViewControllerTemplate: CancellableContainer {
    associatedtype Flow: FlowProtocol
    associatedtype Input where Flow.Input == Input
    associatedtype Output where Flow.Output == Output
    var input: Input { get }
    func bind(output: Output)
}
