//
//  Optional+Extensions.swift
//  AppFoundation
//
//  Created by Metalluxx on 18.04.2021.
//

public extension Optional {
    func or(_ sendThrow: Error) throws -> Wrapped {
        switch self {
        case let .some(object):
            return object
        case .none:
            throw sendThrow
        }
    }

    func `do`(_ closure: (inout Wrapped) -> Void) -> Self {
        if let self = self {
            var copy = self
            closure(&copy)
            return copy
        }

        return self
    }
}
