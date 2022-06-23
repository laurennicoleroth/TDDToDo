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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
  func test_ToDoItem_InitTakesTitle() {
    let item = ToDoItem(title: "Dummy")
    XCTAssertEqual(item.title, "Dummy")
  }
  
  func test_TodoItem_InitTakesItemDescription() {
    let item = ToDoItem(title: "Dummy", itemDescription: "Dummy Description")
    XCTAssertEqual(item.itemDescription, "Dummy Description")
  }

  func test_TodoItem_InitSetsTimestamp() {
    let dummyTimeStamp: TimeInterval = 42.0
    let item = ToDoItem(title: "Dummy", timeStamp: dummyTimeStamp)
    
    XCTAssertEqual(item.timeStamp, dummyTimeStamp)
  }
}
