//
//  AllModules.swift
//  EventPlugins
//
//  Created by Metalluxx on 26.04.2021.
//

public struct Modules {
    public static let AppFoundation = "AppFoundation"
    public static let Application = "Application"
    public static let AuthScreen = "AuthScreen"
    public static let DesignEngine = "DesignEngine"
    public static let EventsScreen = "EventsScreen"
    public static let Networking = "Networking"
    public static let NewNetworking = "NewNetworking"
    public static let NewsScreen = "NewsScreen"
    public static let Platform = "Platform"
    public static let RegistrationScreen = "RegistrationScreen"
    public static let Services = "Services"
    public static let SettingsScreen = "SettingsScreen"
}

extension Modules {
    public static var allCases: [String] {
        [
            AppFoundation,
            Application,
            AuthScreen,
            DesignEngine,
            EventsScreen,
            NewNetworking,
            NewsScreen,
            Platform,
            RegistrationScreen,
            Services,
            SettingsScreen
        ]
    }
}
