//
//  ViewController.swift
//  pupazalupa
//
//  Created by user on 04/05/2020.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

public class AuthViewController: BaseViewController<AuthView> {
	
    public override func viewDidLoad() {
        super.viewDidLoad()
		
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		contentView.addGestureRecognizer(tapGesture)
		contentView.loginBtn.corneredView.addTarget(self, action: #selector(navigateToEvent), for: .touchUpInside)
    }
	
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
	
	@objc func navigateToEvent() {
		globalNavigationController.setViewControllers([MainViewController()], animated: true)
	}
}

