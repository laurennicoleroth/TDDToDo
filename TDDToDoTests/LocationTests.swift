//
//  LocationTests.swift
//  TDDToDoTests
//
//  Created by Lauren N. Roth on 6/23/22.
//

import XCTest
@testable import TDDToDo
import CoreLocation

class LocationTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_Location_initSetsName() throws {
    let location = StorageProvider.default.findOrCreateLocation(id: UUID(), name: "Dummy", latitude: 1.0, longitude: 2.0)
    XCTAssertEqual(location.name, "Dummy")
  }
  
  func test_Location_initSetsCoordinate() throws {

    let location = StorageProvider.default.findOrCreateLocation(id: UUID(), name: "Dummy Name", latitude: 1.0, longitude: 2.0)

    XCTAssertEqual(location.latitude, 1.0, accuracy: 0.000_001)
    XCTAssertEqual(location.longitude, 2.0, accuracy: 0.000_001)
  }
  
}
