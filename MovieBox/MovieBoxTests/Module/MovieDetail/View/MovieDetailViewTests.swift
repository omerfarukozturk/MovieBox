//
//  MovieDetailViewTests.swift
//  MovieBoxTests
//
//  Created by Ömer Faruk Öztürk on 29.10.2019.
//  Copyright © 2019 omerfarukozturk. All rights reserved.
//

import XCTest
@testable import MovieBox

class MovieDetailViewTest: XCTestCase {
    
    func test_detail_controller_deinited() throws {
        let exp = expectation(description: "deinit")
        
        let movie1 = try ResourceLoader.loadMovieItem(resource: .movie1)
        let viewModel = MovieDetailViewModel(movie: movie1)
        var sut: MockDetailView? = MockDetailView(viewModel: viewModel)
        
        sut?.deinitCalled = {
            exp.fulfill()
        }
        
        DispatchQueue.global(qos: .background).async {
            sut = nil
        }
        
        waitForExpectations(timeout: 4.0)
    }
}

private class MockDetailView: MovieDetailViewController {
    var deinitCalled: (() -> Void)?
    deinit { deinitCalled?() }
}
