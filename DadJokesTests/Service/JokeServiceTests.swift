//
//  JokeServiceTests.swift
//  DadJokesTests
//
//  Created by Tulakshana Weerasooriya on 2018-05-31.
//  Copyright © 2018 Tula Weerasooriya. All rights reserved.
//

import XCTest

class JokeServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRandomJokeService() {
        let promise = expectation(description: "Random joke service")
        JokeService.fetchRandomJoke { (aRandomJoke: String?, errorMsg: String?) in
            XCTAssert(aRandomJoke != nil)
            XCTAssert(errorMsg == nil)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5.0) { (error: Error?) in
            if error != nil {
                XCTFail(promise.expectationDescription)
            }
        }
    }
    
    func testRandomJokeServiceWithSearchTerm() {
        let promise = expectation(description: "Random joke service with search term")
        JokeService.fetchRandomJoke(searchTerm: "elephant") { (joke: String?, error: String?) in
            XCTAssert(joke != nil)
            XCTAssert(error == nil)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5.0) { (error: Error?) in
            if error != nil {
                XCTFail(promise.expectationDescription)
            }
        }
    }
    
    func testRandomJokeServiceWithSearchTermAndNoResults() {
        let promise = expectation(description: "Random joke service with search term")
        JokeService.fetchRandomJoke(searchTerm: "tula") { (joke: String?, error: String?) in
            XCTAssert(joke == nil)
            XCTAssert(error == Errors.noResultsFound.rawValue)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5.0) { (error: Error?) in
            if error != nil {
                XCTFail(promise.expectationDescription)
            }
        }
    }
}
