//
//  EventsScreenTests.swift
//  EventsScreenTests
//
//  Created by Araik Garibian on 13.01.2021.
//

import XCTest
import NewNetworking
import Platform
import RxSwift
import Services
@testable import EventsScreen

final class EventsScreenTests: XCTestCase {

	struct MockInput {
		let descriptionDidTap = PublishSubject<Int>()
		let pullToRefresh = PublishSubject<Void>()
	}

	private var sut: EventsListViewModel!
	private var routerSpy: NewsScreenRouterSpy!
	private var serviceSpy: EventsServiceSpy!
	private var input: MockInput!
	private var output: EventsListViewModel.Output!
	private var bag: DisposeBag!
}

extension EventsScreenTests {
	override func setUp() {
		super.setUp()

		routerSpy = .init()
		serviceSpy = .init()
		bag = .init()

		input = .init()
		sut = EventsListViewModel(
			router: routerSpy,
			service: serviceSpy
		)

		let flowInput = EventsListFlow.Input(
			descriptionDidTap: input.descriptionDidTap.asObserver(),
			pullToRefresh: input.pullToRefresh.asObserver()
		)

		output = sut.transform(input: flowInput, bag: bag)
	}

	override func tearDown() {
		sut = nil
		routerSpy = nil
		serviceSpy = nil
		input = nil
		output = nil
		bag = nil

		super.tearDown()
	}
}

extension EventsScreenTests {
	func testPullToRefresh() {
		// Arrange
		var endRefreshingCount = 0
		output.downloadedData.subscribe(onNext: { endRefreshingCount += 1 }).disposed(by: bag)

		// Act
		(0..<5).forEach { _ in
			input.pullToRefresh.onNext(())
		}

		// Assert
		XCTAssertEqual(endRefreshingCount, 5)
		XCTAssertEqual(serviceSpy.calls.count, 6)
	}

	func testLoadingEventsList() throws {
		// Arrange
		let events = try getEvents()
		var newsCount = 0
		output.listData.subscribe(onNext: { newsCount = $0.count }).disposed(by: bag)

		// Act
		serviceSpy.stubbedEvents.onNext(events)

		// Assert
		XCTAssertEqual(newsCount, events.count)
	}

	func testNavigateToNews() throws {
		// Arrange
		let events = try getEvents()
		serviceSpy.stubbedEvents.onNext(events)

		let exp = expectation(description: "Wait sequence")
		input.descriptionDidTap.subscribe(onNext: { _ in exp.fulfill() }).disposed(by: bag)

		// Act
		input.descriptionDidTap.onNext(5)

		// Assert
		wait(for: [exp], timeout: 500)
		XCTAssertEqual(routerSpy.calls.count, 1)
		if case .showNewsScreen(let article) = routerSpy.calls.first {
			XCTAssertEqual(events[5].name, article.title)
			XCTAssertEqual(events[5].place, article.description)
		}
	}

	func testLoadStubbedJson() throws {
		let events = try getEvents()
		XCTAssertEqual(events.count, 9)
	}
}

private extension EventsScreenTests {
	func getRawDataWithEvents() throws -> Data {
		let unwrappedUrl = Bundle(for: Self.self)
			.path(
				forResource: "newsList",
				ofType: "json",
				inDirectory: "FileResources"
			)
			.flatMap(URL.init(fileURLWithPath:))

		let url = try XCTUnwrap(unwrappedUrl)
		return try XCTUnwrap(Data(contentsOf: url))
	}

	func getEvents() throws -> [Events.DTO] {
		return try JSONDecoder()
			.decode(StatusResponseDTO<[Events.DTO]>.self, from: getRawDataWithEvents())
			.data.objects ?? []
	}
}

fileprivate struct StatusResponseDTO<Object: Decodable>: Decodable {
	public let status: String
	public let data: DataResponseDTO<Object>
}

fileprivate struct DataResponseDTO<Object: Decodable>: Decodable {
	public let message: String?
	public let objects: Object?
}
