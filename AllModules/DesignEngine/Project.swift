import ProjectDescription
import PluginHelper

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project(
    name: Modules.DesignEngine,
    targets: [
        .init(
            name: Modules.DesignEngine,
            platform: .iOS,
            product: .staticFramework,
            bundleId: bundleId(for: Modules.DesignEngine),
            infoPlist: .file(path: .relativeToCurrentFile("info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            headers: Headers(
                public: "Headers/**",
                private: nil,
                project: nil
            ),
            dependencies: [
                frameworkPath(for: Frameworks.Kingfisher)
            ]
        ),
        .init(
            name: testTargetName(for: Modules.DesignEngine),
            platform: .iOS,
            product: .unitTests,
            bundleId: testBundleId(for: Modules.DesignEngine),
            infoPlist: .file(path: .relativeToCurrentFile("Tests/TestsInfo.plist")),
            sources: ["Tests/Sources/**"],
            resources: ["Tests/Resources/**"]
        )
    ]
)
