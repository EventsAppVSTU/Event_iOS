//
//  ArrayExtensions.swift
//  AppFoundation
//
//  Created by Araik Garibian on 14.01.2021.
//

import Foundation

public extension Array {
	/// - Parameter index: Индекс элемента, который необходимо получить.
	/// - Returns: Требуемый элемент, если переданный `index` находится в пределах массива.
	subscript(safe index: UInt) -> Element? {
		guard index < UInt(Int.max) else { return nil }

		return self[safe: Int(index)]
	}

	/// - Parameter index: Индекс элемента, который необходимо получить.
	/// - Returns: Требуемый элемент, если переданный `index` находится в пределах массива.
	subscript(safe index: Int) -> Element? {
		return indices ~= index ? self[index] : nil
	}
}
