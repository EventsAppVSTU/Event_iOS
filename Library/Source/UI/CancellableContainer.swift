//
//  ReactiveViewController.swift
//  Library
//
//  Created by Araik Garibian on 5/29/20.
//  Copyright © 2020 Araik Garibian. All rights reserved.
//

import UIKit
import RxSwift

public protocol CancellableContainer {
    var bag: DisposeBag { get }
}
