//
//  FlickrListViewModelTests.swift
//  code-challengeTests
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import Combine
import XCTest
@testable import code_challenge

class CharacterListViewModelTests: XCTestCase {
    var sut: FlickrListViewModel!

    var service: FlickrAPIMock! {
        didSet {
            sut = FlickrListViewModel(flickrFetcher: service)
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        service = FlickrAPIMock()
    }

    func testfetchFlickrList_WhenFails_ShouldHasFailed() throws {
        // given
        service.expectedResult = .failure(APIError.request(message: "Fail"))
        let expectation = XCTestExpectation(description: "Failed is set")
        sut.$hasFailed.dropFirst().sink { hasFailed in
            XCTAssert(hasFailed)
            expectation.fulfill()
        }.store(in: &cancellables)

        // then
        sut.fetchFlickrList(tags: "")

        // when
        wait(for: [expectation], timeout: 1)
    }

    func testFetchFlickrList_WhenSucceed_ShouldLoadedState() {
        // given
        let expectedData = FlickrListResponse.mock
        service.expectedResult = .success(expectedData)
        let expectation = XCTestExpectation(description: "State is loaded")
        sut.$state.dropFirst().sink { state in
            switch state {
            case .loaded(let response):
                XCTAssertEqual(response, expectedData.items)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }.store(in: &cancellables)

        // then
        sut.fetchFlickrList(tags: "")

        // when
        wait(for: [expectation], timeout: 1)
    }
}
