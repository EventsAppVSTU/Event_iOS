//
//  Frameworks.swift
//  PluginHelper
//
//  Created by Metalluxx on 26.04.2021.
//

import ProjectDescription

public struct Frameworks {
    public static let KeychainAccess = "KeychainAccess.xcframework"
    public static let Kingfisher = "Kingfisher.xcframework"
    public static let Overture = "Overture.xcframework"
    public static let Realm = "Realm.xcframework"
    public static let RealmSwift = "RealmSwift.xcframework"
    public static let RxBlocking = "RxBlocking.xcframework"
    public static let RxCocoa = "RxCocoa.xcframework"
    public static let RxRelay = "RxRelay.xcframework"
    public static let RxSwift = "RxSwift.xcframework"
    public static let RxTest = "RxTest.xcframework"
}

public func modulePath(for module: String) -> Path {
    Path.relativeToManifest("../\(module)")
}

public func frameworkPath(for name: String) -> TargetDependency {
    TargetDependency.xcFramework(path: "../../Carthage/Build/\(name)")
}

public func moduleDependency(for module: String) -> TargetDependency {
    .project(
        target: module,
        path: modulePath(for: module)
    )
}

public func screenFrameworks() -> [TargetDependency] {
    [
        frameworkPath(for: Frameworks.RxSwift),
        frameworkPath(for: Frameworks.RxRelay),
        moduleDependency(for: Modules.Platform),
        moduleDependency(for: Modules.AppFoundation),
        moduleDependency(for: Modules.DesignEngine)
    ]
}
