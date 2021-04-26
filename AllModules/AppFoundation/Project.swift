import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: Modules.AppFoundation,
    targets: [
        .init(
            name: Modules.AppFoundation,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.AppFoundation),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                frameworkPath(for: Frameworks.Kingfisher),
                frameworkPath(for: Frameworks.Overture),
                frameworkPath(for: Frameworks.KeychainAccess),
            ]
        ),
        .init(
            name: testTargetName(for: Modules.AppFoundation),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.AppFoundation),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
