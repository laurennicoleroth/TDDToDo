//
//  TaskListCell.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/30/22.
//

import SwiftUI

struct TaskListCell: View {
  @ObservedObject var taskList : TaskList
  @State private var isEdit = false
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        if taskList.isDone {
          Text(taskList.title ?? "").foregroundColor(.gray)
        } else {
          Text(taskList.title ?? "")
        }
        Text("\(taskList.date!.formatted(.dateTime .month().day().hour().minute().second()))").foregroundColor(.gray)
        
      }
      Spacer()
      Button {
        
      } label: {
        Image(systemName: !taskList.isDone ? "circle" : "checkmark.circle")
      }.tint(.blue)
    }
    .sheet(isPresented: $isEdit, content: {
      AddListView(addView: $isEdit)
    })
    .swipeActions(edge: .leading, allowsFullSwipe: true) {
      Button {
        taskList.isFavorite.toggle()
      } label: {
        Label("Favorite", systemImage: taskList.isFavorite ? "heart.slash" : "heart")
      }
    }
    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
      Button(role: .destructive) {
        
      } label: {
        Label("Delete", systemImage: "trash")
      }
      Button {
        isEdit.toggle()
      } label: {
        Label("Edit", systemImage: "pencil")
      }.tint(.yellow)

    }
  }
}

struct TaskListCell_Previews: PreviewProvider {
  static var previews: some View {
    TaskListCell(taskList: TaskList())
  }
}
