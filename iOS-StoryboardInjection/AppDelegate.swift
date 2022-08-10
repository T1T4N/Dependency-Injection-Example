//
//  AppDelegate.swift
//  iOS-StoryboardInjection
//
//  Created by Robert Armenski on 10.08.22.
//

import UIKit

extension UIStoryboard {
	// MARK: Storyboard instance
	static var main: UIStoryboard { .init(name: "Main", bundle: nil) }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	let exampleData = "Injected test string"

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		assert(window != nil)
		assert(window?.rootViewController != nil)

		let rootViewController: UIViewController?

		// In order to have dependency injection with the root view controller:
		// It is necessary to set an empty (dummy) VC as "Is Initial View Controller" in the Storyboard
		// and afterwards manually assign the root `contentViewController`
		// See Also: https://developer.apple.com/documentation/xcode-release-notes/xcode-11-release-notes
		// A Segue Action on a relationship segue between a NSWindowController and a View Controller
		// is currently not supported and ignored. (48252727)

		if #available(iOS 13.0, *) {
			print("Initializing rootViewController on 13.0+")

			// MARK: Perform proper dependency injection with Storyboards on 13.0+
			rootViewController = UIStoryboard.main.instantiateViewController(identifier: "mainViewController") { coder in
				MainViewController(coder: coder, data: self.exampleData)
			}
		} else {
			print("Initializing rootViewController on <13.0")

			// On <13.0 there is no possibility to manually call a different init other than init(coder:)
			let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "mainViewController") as? MainViewController
			// MARK: Perform IUO dependency injection on <13.0
			vc?.data = self.exampleData
			rootViewController = vc
		}

		window?.rootViewController = rootViewController
		window?.makeKeyAndVisible()

		return true
	}

}
