//
//  VehicleSearchUITests.swift
//  VehicleSearchUITests
//
//  Created by Ariful Jannat Arif on 1/13/23.
//

import XCTest

final class VehicleSearchUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
    }
    
    
    func testOnBoardingScreen(){
        
        app.launch()
        
        let title = app.navigationBars["new feature".uppercased()]
        XCTAssertTrue(title.exists)
        
        let nextBtn = app.buttons["try it out".uppercased()]
        XCTAssertTrue(nextBtn.exists)
        
        nextBtn.tap()
        let searchTitle = app.navigationBars["search tool".uppercased()]
        
        XCTAssertTrue(searchTitle.exists)
    }
    
    
    func testInputSearchInput(){
        
        app.launch()
        
        let title = app.navigationBars["new feature".uppercased()]
        XCTAssertTrue(title.exists)
        
        
        let nextBtn = app.buttons["try it out".uppercased()]
        XCTAssertTrue(nextBtn.exists)
        nextBtn.tap()
        
        let searchTitle = app.navigationBars["search tool".uppercased()]
        XCTAssertTrue(searchTitle.exists)
        
        
        let searchField = app.textFields["Enter Reg".uppercased()]
        searchField.tap()
        XCTAssertTrue(searchField.exists)
        searchField.typeText("xxyyzz")
        searchField.typeText("\n")
        
        let goBtn = app.buttons["go".uppercased()]
        XCTAssertTrue(goBtn.exists)
        goBtn.tap()
        
        let progressIndicator = app.otherElements["loading_view"]
        _ = progressIndicator.waitForExistence(timeout: 2)
        XCTAssertTrue(progressIndicator.exists)
        
        let resultView = app.otherElements["result_view"]
        _ = resultView.waitForExistence(timeout: 10)
        
        let errorView = app.otherElements["error_view"]
        
        XCTAssertTrue(resultView.exists || errorView.exists)

        
    }
    
    func testSearchTriggeredUsingKeyboardAction(){
        
        app.launch()
        
        let title = app.navigationBars["new feature".uppercased()]
        XCTAssertTrue(title.exists)
        
        
        let nextBtn = app.buttons["try it out".uppercased()]
        XCTAssertTrue(nextBtn.exists)
        nextBtn.tap()
        
        let searchTitle = app.navigationBars["search tool".uppercased()]
        XCTAssertTrue(searchTitle.exists)
        
        
        let searchField = app.textFields["Enter Reg".uppercased()]
        searchField.tap()
        XCTAssertTrue(searchField.exists)
        searchField.typeText("xxyyzz")
        searchField.typeText("\n")
         
        let progressIndicator = app.otherElements["loading_view"]
        _ = progressIndicator.waitForExistence(timeout: 2)
        XCTAssertTrue(progressIndicator.exists)
        
        let resultView = app.otherElements["result_view"]
        _ = resultView.waitForExistence(timeout: 10)
        
        let errorView = app.otherElements["error_view"]
        
        XCTAssertTrue(resultView.exists || errorView.exists)

        
    }
    
    func testGoTapWithoutSearchInput(){
        
        app.launch()
        
        let title = app.navigationBars["new feature".uppercased()]
        XCTAssertTrue(title.exists)
        
        
        let nextBtn = app.buttons["try it out".uppercased()]
        XCTAssertTrue(nextBtn.exists)
        nextBtn.tap()
        
        let searchTitle = app.navigationBars["search tool".uppercased()]
        XCTAssertTrue(searchTitle.exists)
         
        
        let goBtn = app.buttons["go".uppercased()]
        XCTAssertTrue(goBtn.exists)
        goBtn.tap()
        
        let progressIndicator = app.otherElements["loading_view"]
        _ = progressIndicator.waitForExistence(timeout: 3)
        XCTAssertFalse(progressIndicator.exists)
        
        let resultView = app.otherElements["result_view"]
        _ = resultView.waitForExistence(timeout: 4)
        
        let errorView = app.otherElements["error_view"]
        
        XCTAssertFalse(resultView.exists || errorView.exists)

    }
}
