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
  var storageProvider : StorageProvider!

  override func setUpWithError() throws {
    sut = ToDoItemStore()
    storageProvider = StorageProvider()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_add_shouldAddNewItem() throws {
    
    let location = StorageProvider.default.findOrCreateLocation(id: UUID(), name: "Dummy Location", latitude: 1.0, longitude: 2.0)
    let toDoItem = StorageProvider.default.findOrCreateToDoItem(id: UUID(), title: "Dummy Title", timeStamp: Date(), location: location)

//    let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
//
//    var receivedItems : [DToDoItem] = []
//    let token = sut.items
//      .dropFirst()
//      .sink { items in
//        receivedItems = items
//        publisherExpectation.fulfill()
//      }
//
//    sut.add(toDoItem)
//
//    wait(for: [publisherExpectation], timeout: 1)
//    token.cancel()
//
//    XCTAssertEqual(receivedItems.first?.title, toDoItem.title)
  }
  
  func test_check_shouldPublishChangeInDoneItems() throws {
    let location = StorageProvider.default.findOrCreateLocation(id: UUID(), name: "Dummy", latitude: 1.0, longitude: 2.0)
    let toDoItem = StorageProvider.default.findOrCreateToDoItem(id: UUID(), title: "Dummy Title", itemDescription: "", timeStamp: Date(), location: location, done: false)
    let toDoItem2 = StorageProvider.default.findOrCreateToDoItem(id: UUID(), title: "Dummy 2", itemDescription: "", timeStamp: Date(), location: location, done: false)
    
//    sut.add(toDoItem)
//    sut.add(toDoItem2)
//
//    let receivedItems = try wait(for: sut.itemPublisher)
//    {
//      sut.check(toDoItem)
//    }
//
//    let doneItems = receivedItems.filter({ $0.done })
//
//    XCTAssertEqual(doneItems, [toDoItem])
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
