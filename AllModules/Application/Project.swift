import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: "Application",
    targets: [
        .init(
            name: "Application",
            platform: .iOS,
            product: .app,
            bundleId: bundleId(for: Modules.Application),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                moduleDependency(for: Modules.AppFoundation),
                moduleDependency(for: Modules.NewNetworking),
                moduleDependency(for: Modules.AuthScreen),
                moduleDependency(for: Modules.Platform),
                frameworkPath(for: Frameworks.Kingfisher),
                frameworkPath(for: Frameworks.Overture),
                frameworkPath(for: Frameworks.KeychainAccess),
                frameworkPath(for: Frameworks.RxSwift),
                frameworkPath(for: Frameworks.RxRelay)
            ]
        )
    ]
)
