//
//  Optional+Extensions.swift
//  AppFoundation
//
//  Created by Metalluxx on 18.04.2021.
//

private enum OptionalErrors: String, Error {
    case cannotUnwrap
}

public extension Optional {
    func or(_ sendThrow: Error) throws -> Wrapped {
        switch self {
        case let .some(object):
            return object
        case .none:
            throw sendThrow
        }
    }

    func toResult<E: Error>(_ sendThrow: E) -> Result<Wrapped, E> {
        switch self {
        case let .some(object):
            return .success(object)
        case .none:
            return .failure(sendThrow)
        }
    }

    func unwrapToResult() -> Result<Wrapped, Error> {
        toResult(OptionalErrors.cannotUnwrap)
    }

    func unwrap() throws -> Wrapped {
        switch self {
        case let .some(object):
            return object
        case .none:
            throw OptionalErrors.cannotUnwrap
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
