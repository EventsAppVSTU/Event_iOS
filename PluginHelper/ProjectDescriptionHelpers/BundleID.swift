//
//  BundleID.swift
//  PluginHelper
//
//  Created by Metalluxx on 26.04.2021.
//

import Foundation

public func bundleId(for module: String) -> String {
    return "mx.metalluxx.\(module)"
}

public func testBundleId(for module: String) -> String {
    return "mx.metalluxx.\(module)Tests"
}

public func testTargetName(for module: String) -> String {
    return "\(module)Tests"
}
