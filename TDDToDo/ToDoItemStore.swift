//
//  ToDoItemStore.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/23/22.
//

import Foundation
import CoreData
import SwiftUI
import Combine

//struct DToDoItem {
//  let id: UUID
//  let title: String
//  let itemDescription: String?
//  let timeStamp: Date
//  let location : Location?
//  let done : Bool
//}

class ToDoItemStore : ObservableObject {
  let storageProvider: StorageProvider!
  var itemPublisher =
  CurrentValueSubject<[DToDoItem], Never>([])
//
  private var items: [DToDoItem] = [] {
    didSet {
      itemPublisher.send(items)
    }
  }
  
  @Published private var number_of_persons: Int = 0
  @Published private var message: String = "None"


  init() {
    self.storageProvider = StorageProvider()
  }

  func add(id: UUID, title: String, itemDescription: String?, timeStamp: Date, location: Location, done: Bool = false) {
    let action: Action = {
      let item: ToDoItem = self.storageProvider.findOrCreateToDoItem(id: id, title: title, timeStamp: timeStamp, location: location)
      item.title = title
      item.itemDescription = itemDescription
      item.timeStamp = timeStamp
      item.location = location
      item.done = done
    }
    
    storageProvider
        .publisher(save: action)
        .sink { completion in
            if case .failure(let error) = completion {
              self.message = error.localizedDescription
            }
        } receiveValue: { success in
            if success {
              self.message = "Saving entities succeeded"
              self.number_of_persons += 1
            }
        }
        .store(in: &bag)
  }

  func check(_ item: ToDoItem) {

  }
}
