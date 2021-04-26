import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: Modules.RegistrationScreen,
    targets: [
        .init(
            name: Modules.RegistrationScreen,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.RegistrationScreen),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: screenFrameworks() + [
                moduleDependency(for: Modules.Services)
            ]
        ),
        .init(
            name: testTargetName(for: Modules.RegistrationScreen),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.RegistrationScreen),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
