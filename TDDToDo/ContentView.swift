//
//  ContentView.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/22/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject var taskListVM: TaskListViewModel
  @State var addView : Bool = false
  
  @FetchRequest(entity: TaskList.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)]) var fetchedTaskList: FetchedResults<TaskList>
  
  var body: some View {
    NavigationView {
      List() {
        ForEach(fetchedTaskList) { taskList in
          TaskListCell(taskList: taskList)
        }
      }
      .sheet(isPresented: $addView, content: {
        AddListView(addView: $addView)
      })
      .toolbar {
        Button {
          addView.toggle()
        } label: {
          Label("Add Item", systemImage: "plus")
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .tint(.yellow)
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
      }
      .navigationTitle("Add Item")
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
