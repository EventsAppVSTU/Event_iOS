import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: Modules.SettingsScreen,
    targets: [
        .init(
            name: Modules.SettingsScreen,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.SettingsScreen),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: screenFrameworks()
        ),
        .init(
            name: testTargetName(for: Modules.SettingsScreen),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.SettingsScreen),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
