//
//  MovieServiceTest.swift
//  VO2VideoTests
//
//  Created by Thejus on 16/03/2023.
//

import XCTest
@testable import VO2Video

final class MovieServiceTest: XCTestCase {

    let testEngine = Engine()
    
    func testGetPopularMovies() {
        let expectation = self.expectation(description: "testGetPopularMovies")
        testEngine.moviesService.getPopularMovies(pageNo: 1) { result in
            switch result {
            case .success(let ds):
                XCTAssertFalse(ds.results?.isEmpty ?? true)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
