//
//  Main.swift
//  Application
//
//  Created by Araik Garibian on 6/13/20.
//

import UIKit

@main struct Application {
	static func main() throws {
		UIApplicationMain(
			CommandLine.argc,
			CommandLine.unsafeArgv,
			NSStringFromClass(UIApplication.self),
			NSStringFromClass(AppDelegate.self)
		)
	}
}
