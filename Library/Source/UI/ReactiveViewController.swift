//
//  ReactiveViewController.swift
//  Library
//
//  Created by Araik Garibian on 5/29/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import UIKit
import Combine


public protocol CancellableContainer {
    var bag: Set<AnyCancellable> { get }
}

