//
//  TaskListViewModel.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/30/22.
//

import Foundation
import Combine
import CoreData

class TaskListViewModel: ObservableObject {
  @Published var taskListTitle = ""
  
  func createTask(context: NSManagedObjectContext) {
    let task = TaskList(context: context)
    task.title = taskListTitle
    task.isDone = false
    task.isFavorite = false
    task.date = Date()
    task.id = UUID()
    save(context: context)
  }
  
  func save(context: NSManagedObjectContext) {
    do {
      try context.save()
    } catch {
      print(error)
    }
  }
}
