//
//  ToDoItemStore.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/23/22.
//

import Foundation
import Combine

class ToDoItemStore {
  var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([])
  
  private var items: [ToDoItem] = [] {
    didSet {
      itemPublisher.send(items)
    }
  }
  
  func add(_ item: ToDoItem) {
    items.append(item)
  }
}
