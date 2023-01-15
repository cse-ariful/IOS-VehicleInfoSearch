//
//  VehicleSearchUITestsLaunchTests.swift
//  VehicleSearchUITests
//
//  Created by Ariful Jannat Arif on 1/13/23.
//

import XCTest

final class VehicleSearchUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
