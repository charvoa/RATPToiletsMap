//
//  RATPTestTests.swift
//  RATPTestTests
//
//  Created by Nicolas Charvoz on 10/02/2024.
//

import XCTest
@testable import RATPTest

final class RATPTestTests: XCTestCase {
    func testLocationServiceMethods() throws {
        XCTAssert(LocationService.displayDistance(600) == "0.6 km")
        XCTAssert(LocationService.displayDistance(90) == "90 m")
        XCTAssert(LocationService.displayDistance(100) == "100 m")
        XCTAssert(LocationService.displayDistance(101) == "0.1 km")
    }
}
