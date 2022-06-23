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
    let location = Location(name: "Dummy")
    XCTAssertEqual(location.name, "Dummy")
  }
  
  func test_Location_initSetsCoordinate() throws {
    let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
    let location = Location(name: "Dummy", coordinate: coordinate)
    
    let resultCoordinate = try XCTUnwrap(location.coordinate)
    XCTAssertEqual(resultCoordinate.latitude, 1, accuracy: 0.000_001)
    XCTAssertEqual(resultCoordinate.longitude, 2, accuracy: 0.000_001)
  }
  
  
  
}
