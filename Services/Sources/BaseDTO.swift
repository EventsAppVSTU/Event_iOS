//
//  BaseDTO.swift
//  Services
//
//  Created by Araik Garibian on 12.01.2021.
//

struct StatusResponseDTO<Object: Decodable>: Decodable {
	public let status: String
	public let data: DataResponseDTO<Object>
}

struct DataResponseDTO<Object: Decodable>: Decodable {
	public let message: String?
	public let objects: Object?
}
