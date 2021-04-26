import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: Modules.NewNetworking,
    targets: [
        .init(
            name: Modules.NewNetworking,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.NewNetworking),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                frameworkPath(for: Frameworks.RxSwift),
                frameworkPath(for: Frameworks.RxRelay)
            ]
        ),
        .init(
            name: testTargetName(for: Modules.NewNetworking),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.NewNetworking),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
