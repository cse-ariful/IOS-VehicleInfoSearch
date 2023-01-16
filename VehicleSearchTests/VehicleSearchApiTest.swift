//
//  MockApiTest.swift
//  VehicleSearchTests
//
//  Created by Ariful Jannat Arif on 1/15/23.
//


import XCTest
@testable import VehicleSearch

final class VehicleSearchApiTest : XCTestCase {

   
    func testVehicleSearchApi() throws {
        
        let testRegNo = "xxyyzz"
        
        let queryApi = VehicleSearchApi.queryVehicleDetails(regNo: testRegNo)
        
        XCTAssertTrue(queryApi.host == "da4705d6-9b2b-4f2a-8f19-6db21183fd13.mock.pstmn.io")
       
        XCTAssertTrue(queryApi.queryItems != nil)
        
        XCTAssertTrue(queryApi.queryItems!["registration"]  == testRegNo)
        
        let request  = queryApi.request
        
        XCTAssertTrue(request?.httpMethod=="GET")
        
        XCTAssertTrue(request?.value(forHTTPHeaderField: "x-api-key") != nil )
        
    }

     

}
