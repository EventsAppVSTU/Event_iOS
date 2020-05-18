//
//  BaseViewController.swift
//  pupazalupa
//
//  Created by Araik Garibian on 5/18/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit


public class BaseViewController<View: UIView>: UIViewController {
	private(set) var contentView: View!
	
	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		setup()
	}
	
	public required init?(coder: NSCoder) {
		fatalError()
	}
    
    func setup() {}
    
    override public func loadView() {
        contentView = View()
        view = contentView
    }
}
