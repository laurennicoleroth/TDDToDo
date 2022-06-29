//
//  ContentView.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/22/22.
//

import SwiftUI
import CoreData
import Combine

var bag: [AnyCancellable] = []

struct ContentView: View {
  @State private var message: String = "None"
  @FetchRequest(sortDescriptors: [SortDescriptor(\.timeStamp, order: .reverse)])
  private var items: FetchedResults<ToDoItem>
  
  var body: some View {
    VStack {
      Text("number of items \(items.count)")
        .padding()
      List {
        ForEach(items, id: \.id) { item in
          Text(item.title)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
