//
//  MovieServiceTest.swift
//  VO2VideoTests
//
//  Created by Shiny on 16/03/2023.
//

import XCTest
@testable import VO2Video

final class MovieServiceTest: XCTestCase {

    let testEngine = Engine()
    
    func testGetAllMovies() {
        let expectation = self.expectation(description: "testGetAllMovies")
        testEngine.rMService.getAllCharachters(
            pageNo: 1
        ){ result in
            switch result {
            case .success(let ds):
                XCTAssertFalse(ds.results.isEmpty)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
