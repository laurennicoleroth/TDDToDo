//
//  TDDToDoApp.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/22/22.
//

import SwiftUI

@main
struct TDDToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
