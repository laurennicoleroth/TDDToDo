//
//  ToDoItem.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/23/22.
//

import Foundation

struct ToDoItem : Equatable {
  let title : String
  let itemDescription : String?
  let timeStamp : TimeInterval?
  let location : Location?
  
  init(title: String, itemDescription: String? = nil, timeStamp: TimeInterval? = nil, location : Location? = nil) {
    self.title = title
    self.itemDescription = itemDescription
    self.timeStamp = timeStamp
    self.location = location
  }
}
