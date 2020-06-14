//
//  ANSIColors.swift
//  Library
//
//  Created by Araik Garibian on 6/14/20.
//

import Foundation

public enum ANSIColors: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"

	public var name: String {
        switch self {
        case .black: return "Black"
        case .red: return "Red"
        case .green: return "Green"
        case .yellow: return "Yellow"
        case .blue: return "Blue"
        case .magenta: return "Magenta"
        case .cyan: return "Cyan"
        case .white: return "White"
        }
    }

	public static let all: [ANSIColors] = [.black, .red, .green, .yellow, .blue, .magenta, .cyan, .white]
}

public func + (left: ANSIColors, right: String) -> String {
    return left.rawValue + right
}
