//
//  ToDoItemStoreTests.swift
//  TDDToDoTests
//
//  Created by Lauren N. Roth on 6/23/22.
//

import XCTest
import Combine
@testable import TDDToDo

class ToDoItemStoreTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_add_shouldPublushChange() throws {
    let sut = ToDoItemStore()
    let toDoItem = ToDoItem(title: "Dummy")
    let receivedItems = try wait(for: sut.itemPublisher) {
      sut.add(toDoItem)
    }
    
    XCTAssertEqual(receivedItems, [toDoItem])
  }
}

extension XCTestCase {
  func wait<T: Publisher>(
    for publisher: T,
    afterChange change: () -> Void,
    file: StaticString = #file,
    line: UInt = #line) throws
  -> T.Output where T.Failure == Never {
    
    let publisherExpectation = expectation(
      description: "Wait for publisher in \(#file)"
    )
    
    var result: T.Output?
    
    let token = publisher
      .dropFirst()
      .sink { value in
        result = value
        publisherExpectation.fulfill()
      }
    change()
    
    wait(for: [publisherExpectation], timeout: 1)
    
    token.cancel()
    
    let unwrappedResult = try XCTUnwrap(
      result,
      "Publisher did not publish any value"
    )
    
    return unwrappedResult
  }
}
