//
//  ExampleViewController.swift
//  macOS-XibInjection
//
//  Created by Robert Armenski on 10.08.22.
//

import Cocoa

class ExampleViewController: NSViewController {
	@IBOutlet weak var dataField: NSTextField!

	public var data: String {
		didSet {
			print("\(Self.self):\(#function):didSet")
			// Refresh UI when data changes
			updateUI()
		}
	}

	// MARK: Regular Dependency Injection
	public init(data: String) {
		self.data = data
		super.init(nibName: "ExampleViewController", bundle: Bundle(for: Self.self))
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do view setup here.
		updateUI()
	}

	func updateUI() {
		guard self.isViewLoaded else { return }
		dataField.stringValue = self.data
	}
}
