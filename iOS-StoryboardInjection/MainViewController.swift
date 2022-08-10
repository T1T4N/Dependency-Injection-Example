//
//  ViewController.swift
//  iOS-StoryboardInjection
//
//  Created by Robert Armenski on 10.08.22.
//

import UIKit

class MainViewController: UIViewController {
	@IBOutlet private weak var dataLabel: UILabel!

	public var data: String {
		didSet {
			print("\(Self.self):\(#function):didSet")
			// Refresh UI when data changes
			updateUI()
		}
	}

	// MARK: Regular Dependency Injection
	public init?(coder: NSCoder, data: String) {
		self.data = data
		super.init(coder: coder)
		print("\(Self.self):\(#function):Called by directly by us, not by AppKit")
	}

	// Mark as unavailable, not to be called by our code directly
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		// A sane default if possible, otherwise must use an IUO
		self.data = ""

		super.init(coder: coder)
		print("\(Self.self):\(#function):Called by AppKit, not directly by us")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		updateUI()
	}

	func updateUI() {
		guard self.isViewLoaded else { return }
		dataLabel.text = data
	}

	// prepareForSegue successor
	// SeeAlso: [Improving Storyboard Segues with IBSegueAction](https://www.raywenderlich.com/9296192-improving-storyboard-segues-with-ibsegueaction)
	@IBSegueAction func makeNextViewController(_ coder: NSCoder) -> UIViewController? {
		// MARK: - Real Dependency Injection with segues
		return NextViewController(coder: coder, text: "Propagated \(data)")
	}

}
