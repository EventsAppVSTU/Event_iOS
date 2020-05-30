//
//  Complete.swift
//  Library
//
//  Created by Araik Garibian on 5/30/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import Foundation

public enum Complete<ErrorType> {
	case success
	case failure(error: ErrorType)
}
