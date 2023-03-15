//
//  VO2VideoTests.swift
//  VO2VideoTests
//
//  Created by Thejus on 15/03/2023.
//

import XCTest
@testable import VO2Video

final class HomeViewModelTests: XCTestCase {

    let testableEngine = Engine()
    
    lazy var homeViewModel = HomeViewModel(engine: testableEngine)
    
    func testHomeViewModel() {
        let expectation = self.expectation(description: "testHomeViewModel")
        homeViewModel.getAllPopularMovies { [weak self] result in
            guard let self else { fatalError() }
            switch result {
            case .success:
                XCTAssertFalse(self.homeViewModel.allPopularMovies?.isEmpty ?? true)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        loadMoreMoviesIfNeeded(previousCount: homeViewModel.allPopularMovies?.count ?? 0)
    }
    func loadMoreMoviesIfNeeded(previousCount: Int) {
        let expectation = self.expectation(description: "loadMoreMoviesIfNeeded")
        homeViewModel.loadMorePopularMoviesIfNeeded { [weak self] error in
            guard let self = self else { fatalError() }
            XCTAssertNil(error)
            XCTAssertTrue(self.homeViewModel.allPopularMovies?.count ?? 0 > previousCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testFetchingMovieDetails() {
        let testMovie = Movie(
            id: 550, overview: nil, rating: nil, title: nil, releaseDate: nil, posterPath: nil
        )
        let expectation = self.expectation(description: "testFetchingMovieDetails")
        
        homeViewModel.getDetailsOf(movie: testMovie) { details, error in
            if error != nil {
                XCTFail()
            } else {
                XCTAssertFalse(details == nil)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
