//
//  GoogleSearchTests.swift
//  GoogleSearchTests
//
//  Created by Rajneesh on 07/03/21.
//  Copyright © 2021 BRRV. All rights reserved.
//

import XCTest
@testable import GoogleSearch

class GoogleSearchTests: XCTestCase {
    let sessionNew = MockURLSession()
    
    override func setUp() {
        sessionNew.nextData = TestData.data
    }
    
    override func tearDown() {
        sessionNew.nextData = nil
    }
    
    func testSearchWithoutText() {
        let viewModel = GoogleSearchViewModel()
        viewModel.search(item: "")
        XCTAssertEqual(viewModel.searchResult.count, 0, "Something went wrong")
    }
    
    func testSearchDebounce() {
        /* current debounce is 0.2 sec.
         So before debounce, search results are 0
         */
        
        let viewModel = GoogleSearchViewModel()
        viewModel.provider.urlSession = sessionNew
        viewModel.searchString = "hello"
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            XCTAssertEqual(viewModel.searchResult.count, 0, "Debounce not working properly went wrong")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchWithText() {
        let sessionNew = MockURLSession()
        sessionNew.nextData = TestData.data
        let viewModel = GoogleSearchViewModel()
        viewModel.provider.urlSession = sessionNew
        viewModel.searchString = "hello"
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(viewModel.searchResult.count, 10, "Something went wrong")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
