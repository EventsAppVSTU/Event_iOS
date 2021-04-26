import ProjectDescription

let config = Config(
    plugins:[.local(path: .relativeToRoot("PluginHelper"))],
    generationOptions: [
        .developmentRegion("ru"),
        .enableCodeCoverage,
        .organizationName("metalluxx")
    ]
)
