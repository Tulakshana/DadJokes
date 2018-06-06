//
//  RandomJokeSearchVCUITests.swift
//  DadJokesUITests
//
//  Created by Tulakshana Weerasooriya on 2018-06-05.
//  Copyright © 2018 Tula Weerasooriya. All rights reserved.
//

import XCTest

class RandomJokeSearchVCUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSearch() {
        
        let app = XCUIApplication()
        app.navigationBars["A Random Joke !!!"].buttons["Search"].tap()
        
        app.alerts["Search for a random joke"].textFields[Constants.searchInputAccessibilityIdentifier].typeText("elephant")
        app.alerts["Search for a random joke"].buttons["Search"].tap()

        sleep(5)
        
        if let text: String = XCUIApplication().textViews["textView"].value as? String {
            XCTAssert(text.range(of: "elephant") != nil)
        }
    }
}
