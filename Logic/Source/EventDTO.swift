//
//  EventDTO.swift
//  Logic
//
//  Created by Araik Garibian on 6/14/20.
//

import Foundation

public struct EventDTO: Decodable {
	public let id: String
	public let name: String
	public let description: String
	public let startDate: String
	public let endDate: String
	public let image: String
	public let place: String
}

public struct StatusResponseDTO<Object: Decodable>: Decodable {
	public let status: String
	public let data: DataResponseDTO<Object>

}

public struct DataResponseDTO<Object: Decodable>: Decodable {
	public let message: String?
	public let objects: Object?
}
