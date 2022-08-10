//
//  NextViewController.swift
//  iOS-StoryboardInjection
//
//  Created by Robert Armenski on 10.08.22.
//

import UIKit

class NextViewController: UIViewController {
	@IBOutlet private weak var dataLabel: UILabel!

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
		dataLabel.text = text
	}
}
