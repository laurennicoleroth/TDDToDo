//
//  TaskListViewModel.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/30/22.
//

import Foundation
import Combine
import CoreData
import SwiftUI

class TaskListViewModel: ObservableObject {
  @Published var taskListTitle = ""
  @Published var taskList: TaskList!
  
  func createTask(context: NSManagedObjectContext) {
    if taskList == nil {
      let task = TaskList(context: context)
      task.title = taskListTitle
      task.isDone = false
      task.isFavorite = false
      task.date = Date()
      task.id = UUID()
    } else {
      taskList.title = taskListTitle
    }
    
    save(context: context)
    taskListTitle = ""
  }
  
  func save(context: NSManagedObjectContext) {
    do {
      try context.save()
    } catch {
      print(error)
    }
  }
  
  func delete(task: TaskList, context: NSManagedObjectContext) {
    context.delete(task)
    save(context: context)
  }
  
  func editList(task: TaskList) {
    taskList = task
  }
  
  func toggleFavorite(task: TaskList, context: NSManagedObjectContext) {
    task.isFavorite.toggle()
    save(context: context)
  }
  
  func toggleDone(task: TaskList, context: NSManagedObjectContext) {
    task.isDone.toggle()
    save(context: context)
  }
}
