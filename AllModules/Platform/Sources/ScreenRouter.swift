//
//  ScreenRouter.swift
//  Platform
//
//  Created by Metalluxx on 28.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

public protocol ScreenRouterProtocol {
    associatedtype Arg

    func show(_ arg: Arg)
}

public extension ScreenRouterProtocol where Arg == Void {
    func show() {
        self.show(())
    }
}

public typealias AnyRouter<R: ScreenRouterProtocol> = AnyRouterWithArg<R, R.Arg>

public struct AnyRouterWithArg<R, A> where R: ScreenRouterProtocol, A == R.Arg {
    private let rawRouter: R

    public init(_ rawRouter: R) {
        self.rawRouter = rawRouter
    }
}

extension AnyRouter: ScreenRouterProtocol {
    public typealias Arg = A

    public func show(_ arg: A) {
        rawRouter.show(arg)
    }
}
