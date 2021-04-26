import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: Modules.EventsScreen,
    targets: [
        .init(
            name: Modules.EventsScreen,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.EventsScreen),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: screenFrameworks() + [
                moduleDependency(for: Modules.Services),
                moduleDependency(for: Modules.NewsScreen)
            ]
        ),
        .init(
            name: testTargetName(for: Modules.EventsScreen),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.EventsScreen),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
