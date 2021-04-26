//
//  Workspace.swift
//  Event_iOSManifests
//
//  Created by Metalluxx on 26.04.2021.
//

import Foundation
import ProjectDescription
import PluginHelper

let workspace = Workspace(
    name: "EventWorkspace",
    projects: PluginHelper.Modules.allCases.map { Path("AllModules" + "/" + $0) }
)
