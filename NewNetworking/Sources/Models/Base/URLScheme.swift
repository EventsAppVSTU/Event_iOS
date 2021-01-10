//
//  URLScheme.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/29/20.
//

public struct URLScheme {
	public static let https = Self(rawValue: "https")
	public static let http = Self(rawValue: "http")
	public static let ftp = Self(rawValue: "ftp")

	public let rawValue: String

	public init(rawValue: String) {
		self.rawValue = rawValue
	}
}
