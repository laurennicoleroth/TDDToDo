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
            Text("Add item")
          }
        }
      }
    }
  }
}
