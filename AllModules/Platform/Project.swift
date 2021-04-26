import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: Modules.Platform,
    targets: [
        .init(
            name: Modules.Platform,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.Platform),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                frameworkPath(for: Frameworks.RxSwift),
                frameworkPath(for: Frameworks.RxRelay),
                moduleDependency(for: Modules.NewNetworking),
                moduleDependency(for: Modules.AppFoundation)
            ]
        ),
        .init(
            name: testTargetName(for: Modules.Platform),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.Platform),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
