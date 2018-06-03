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
        let promise = expectation(description: "Random Joke Service")
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
}
