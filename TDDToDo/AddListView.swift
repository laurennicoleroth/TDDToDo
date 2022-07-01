//
//  AddListView.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/30/22.
//

import SwiftUI

struct AddListView: View {
  @Environment(\.managedObjectContext) var viewContext
  @EnvironmentObject var taskListVM: TaskListViewModel
  @Binding var addView : Bool
  
  
  var body: some View {
    NavigationView {
      Form {
        VStack {
          TextField("Enter title", text: $taskListVM.taskListTitle)
          
          Button(action: {
            taskListVM.createTask(context: viewContext)
            addView.toggle()
          }) {
           
            Text(taskListVM.taskList == nil ? "Add item" : "Update Item").frame(minWidth: 0, maxWidth: .infinity)
            
          }
        }
      }.navigationTitle(taskListVM.taskList == nil ? "Add Item" : "Edit")
    }
  }
}
