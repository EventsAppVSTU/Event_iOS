import ProjectDescription
import PluginHelper

// MARK: - Project

let project = Project(
    name: Modules.AuthScreen,
    targets: [
        .init(
            name: Modules.AuthScreen,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.AuthScreen),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: screenFrameworks() + [
                moduleDependency(for: Modules.EventsScreen),
                moduleDependency(for: Modules.RegistrationScreen),
                moduleDependency(for: Modules.SettingsScreen),
                moduleDependency(for: Modules.Services)
            ]
        ),
        .init(
            name: testTargetName(for: Modules.AuthScreen),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.AuthScreen),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
