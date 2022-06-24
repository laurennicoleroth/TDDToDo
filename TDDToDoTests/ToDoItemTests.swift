//
//  ToDoItemTests.swift
//  TDDToDoTests
//
//  Created by Lauren N. Roth on 6/23/22.
//

import XCTest
@testable import TDDToDo

class ToDoItemTests: XCTestCase {

  override func setUpWithError() throws {

  }
  
  override func tearDownWithError() throws {

  }
  
  func test_ToDoItem_InitTakesTitle() throws {
    let location = StorageProvider.default.findOrCreateLocation(id: UUID(), name: "Dummy", latitude: 1.0, longitude: 2.0)
    let item = StorageProvider.default.findOrCreateToDoItem(id: UUID(), title: "Dummy", timeStamp: Date(), location: location)
    XCTAssertEqual(item.title, "Dummy")
  }
  
  func test_TodoItem_InitTakesItemDescription() throws {
    let location = StorageProvider.default.findOrCreateLocation(id: UUID(), name: "Dummy", latitude: 1.0, longitude: 2.0)
    let item = StorageProvider.default.findOrCreateToDoItem(id: UUID(), title: "Dummy", itemDescription: "Dummy Description", timeStamp: Date(), location: location)
    XCTAssertEqual(item.itemDescription, "Dummy Description")
  }
  
  func test_TodoItem_InitSetsTimestamp() throws {
    let dummyTimeStamp = Date()
    let location = StorageProvider.default.findOrCreateLocation(id: UUID(), name: "Dummy", latitude: 1.0, longitude: 2.0)
    let item = StorageProvider.default.findOrCreateToDoItem(id: UUID(), title: "Dummy", timeStamp: dummyTimeStamp, location: location)
    let timeStamp = try XCTUnwrap(item.timeStamp)
    XCTAssertEqual(timeStamp, dummyTimeStamp)
  }
  
  func test_TodoItem_whenGivenLocation_setsLocation() {
    let dummyLocation = StorageProvider.default.findOrCreateLocation(id: UUID(), name: "Dummy", latitude: 1.0, longitude: 2.0)
    let item = StorageProvider.default.findOrCreateToDoItem(id: UUID(), title: "Dummy", timeStamp: Date(), location: dummyLocation)

    
    XCTAssertEqual(item.location?.name, dummyLocation.name)
  }
}
