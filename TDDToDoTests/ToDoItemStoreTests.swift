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
  
  var sut: ToDoItemStore!
  
  override func setUpWithError() throws {
    sut = ToDoItemStore()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_add_shouldPublushChange() throws {
    let toDoItem = ToDoItem(title: "Dummy")
    let receivedItems = try wait(for: sut.itemPublisher) {
      sut.add(toDoItem)
    }
    
    XCTAssertEqual(receivedItems, [toDoItem])
  }
  
  func test_check_shouldPublishChangeInDoneItems() throws {
    let toDoItem = ToDoItem(title: "Dummy")
    sut.add(toDoItem)
    sut.add(ToDoItem(title: "Dummy 2"))
    let receivedItems = try wait(for: sut.itemPublisher)
    {
      sut.check(toDoItem)
    }
    let doneItems = receivedItems.filter({ $0.done })
    XCTAssertEqual(doneItems, [toDoItem])
  }
  
  func test_load_shouldLoadPreviousToDoItems() {
    
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
