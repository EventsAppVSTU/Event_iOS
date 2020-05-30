//
//  BaseViewController.swift
//   
//
//  Created by Araik Garibian on 5/18/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

open class ContentViewController<View: UIView>: UIViewController {
	
    open private(set) var viewLoader: () -> View = {
        return View()
    }
	
	public private(set) var contentView: View!
	
	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		setup()
	}
	
	public init() {
		super.init(nibName: nil, bundle: nil)
		
		setup()
	}
	
	public required init?(coder: NSCoder) {
		fatalError()
	}
    
    open func setup() {}
    
    override open func loadView() {
        contentView = viewLoader()
        view = contentView
    }
}
