//
//  BaseViewController.swift
//   
//
//  Created by Araik Garibian on 5/18/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

open class ContentViewController<View: UIView>: UIViewController {

	public private(set) var contentView: View!

	open private(set) var viewLoader: () -> View = {
		return View()
	}

	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		afterInit()
	}

	public init() {
		super.init(nibName: nil, bundle: nil)

		afterInit()
	}

	open func afterInit() {}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override open func loadView() {
		contentView = viewLoader()
		view = contentView
	}
}
