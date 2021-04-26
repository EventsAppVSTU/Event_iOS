import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: Modules.Services,
    targets: [
        .init(
            name: Modules.Services,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.Services),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                frameworkPath(for: Frameworks.RxSwift),
                frameworkPath(for: Frameworks.RxRelay),
                moduleDependency(for: Modules.NewNetworking)
            ]
        ),
        .init(
            name: testTargetName(for: Modules.Services),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.Services),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
