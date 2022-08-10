//
//  NextViewController.swift
//  macOS-StoryboardInjection
//
//  Created by Robert Armenski on 10.08.22.
//

import Cocoa

class NextViewController: NSViewController {
	@IBOutlet weak var textField: NSTextField!

	public var text: String {
		didSet {
			print("\(Self.self):\(#function):didSet")
			// Refresh UI when data changes
			updateUI()
		}
	}

	// MARK: Regular Dependency Injection
	public init?(coder: NSCoder, text: String) {
		self.text = text
		super.init(coder: coder)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		updateUI()
	}

	func updateUI() {
		guard self.isViewLoaded else { return }
		textField.stringValue = text
	}
}
