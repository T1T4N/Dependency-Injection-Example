//
//  AppDelegate.swift
//  macOS-XibInjection
//
//  Created by Robert Armenski on 10.08.22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet var window: NSWindow!

	let sampleString = "Injected test string"

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// MARK: Perform dependency injection
		let vc = ExampleViewController(data: self.sampleString)
		window.contentViewController = vc
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		return true
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		true
	}

}
