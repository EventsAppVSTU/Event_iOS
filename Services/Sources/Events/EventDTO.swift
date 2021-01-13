//
//  EventDTO.swift
//  Logic
//
//  Created by Araik Garibian on 6/14/20.
//

public extension Events {
	struct DTO: Decodable {
		public let id: String
		public let name: String
		public let description: String
		public let startDate: String
		public let endDate: String
		public let image: String
		public let place: String
	}
}
