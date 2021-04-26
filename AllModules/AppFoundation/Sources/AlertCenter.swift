//
//  AlertCenter.swift
//  AppFoundation
//
//  Created by Metalluxx on 26.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

import UIKit

public protocol AlertCenterProtocol: AnyObject {
    func alert(title: String, description: String)
}

public final class AlertCenter {
    private let navigarionController: UINavigationController

    public init(navigarionController: UINavigationController) {
        self.navigarionController = navigarionController
    }
}

extension AlertCenter: AlertCenterProtocol {
    public func alert(title: String, description: String) {
        let controller = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .alert
        )

        controller.addAction(UIAlertAction(
            title: "Ok",
            style: .cancel,
            handler: { _ in controller.dismiss(animated: true, completion: nil) }
        ))

        navigarionController.present(controller, animated: true)
    }
}
