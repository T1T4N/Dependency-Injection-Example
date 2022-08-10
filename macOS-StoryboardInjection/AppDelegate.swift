//
//  AppDelegate.swift
//  macOS-StoryboardInjection
//
//  Created by Robert Armenski on 10.08.22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	var window: NSWindow! { NSApplication.shared.windows.first }

	// MARK: Storyboard instance
	static var mainStoryboard: NSStoryboard {
		if #available(macOS 10.13, *) {
			return NSStoryboard.main!
		} else {
			return NSStoryboard(name: "Main", bundle: nil)
		}
	}

	let exampleData = "Injected test string"

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		assert(self.window != nil)

		let controller = self.window.windowController

		// In order to have dependency injection with the root view controller:
		// It is necessary to remove the "window content" segue from the Storyboard
		// and manually assign the root `contentViewController` because
		// https://developer.apple.com/documentation/xcode-release-notes/xcode-11-release-notes
		// A Segue Action on a relationship segue between a NSWindowController and a View Controller
		// is currently not supported and ignored. (48252727)

		if #available(macOS 10.15, *) {
			print("Initializing contentViewController on 10.15+")

			// MARK: Perform proper dependency injection with Storyboards on 10.15+
			controller?.contentViewController = Self.mainStoryboard.instantiateController(identifier: "mainContentViewController") { coder in
				ViewController(coder: coder, data: self.exampleData)
			}
		} else {
			print("Initializing contentViewController on <10.15")

			// On <10.15 there is no possibility to manually call a different init other than init(coder:)
			let vc = Self.mainStoryboard.instantiateController(withIdentifier: "mainContentViewController") as? ViewController
			// MARK: Perform IUO dependency injection on <10.15
			vc?.data = self.exampleData
			controller?.contentViewController = vc
		}

		controller?.showWindow(self)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		true
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		true
	}

}
