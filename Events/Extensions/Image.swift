//
//  Image.swift
//  Events
//
//  Created by Araik Garibian on 5/25/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Kingfisher

public enum Image: Hashable {
	indirect case local(object: UIImage)
	case asset(name: String)
	case remote(url: URL)
	case system(name: String)
}


public extension UIImageView {
	func set(image: Image?, options:KingfisherOptionsInfo? = nil) {
		kf.cancelDownloadTask()
		
		guard let image = image else {
			self.image = nil
			return
		}
		

		switch image {
		case .system(let name):
			let image = UIImage(systemName: name)
			self.image = image
		case .asset(let name):
			let image = UIImage(named: name)
			self.image = image
		case .local(let object):
			self.image = object
		case .remote(let url):
			var newOptions: KingfisherOptionsInfo = [.transition(.fade(0.3))]
			
			if let options = options {
				newOptions.append(contentsOf: options)
			}
			
			kf.setImage(
				with: url,
				options: newOptions
			)
		}
	}
}

