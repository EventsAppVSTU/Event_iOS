//
//  EmptyRawRepresentable.swift
//  Library
//
//  Created by Araik Garibian on 6/14/20.
//

import Foundation

public protocol EmptyRawRepresentable: RawRepresentable {}

public extension EmptyRawRepresentable {
    init?(rawValue: Self.RawValue) {
        return nil
    }
}
