//
//  Setup.swift
//  Event_iOSManifests
//
//  Created by Metalluxx on 26.04.2021.
//

import ProjectDescription

let setup = Setup([
    .mint(),
    .carthage(
        platforms: [.iOS],
        useXCFrameworks: true,
        noUseBinaries: false
    )
])
