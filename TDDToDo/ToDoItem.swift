//
//  ToDoItem.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/23/22.
//

import Foundation

struct ToDoItem {
  let title : String
  let itemDescription : String?
  let timeStamp : TimeInterval?
  
  init(title: String, itemDescription: String? = nil, timeStamp: TimeInterval? = nil) {
    self.title = title
    self.itemDescription = itemDescription
    self.timeStamp = timeStamp
  }
}
