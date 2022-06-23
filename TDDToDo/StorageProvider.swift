//
//  StorageProvider.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/23/22.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

final class StorageProvider {
  enum StoreType {
    case inMemory, persisted
  }
  
  static var managedObjectModel: NSManagedObjectModel = {
    let bundle = Bundle(for: StorageProvider.self)
    guard let url = bundle.url(forResource: "TDDToDo", withExtension: "momd") else {
      fatalError("Failed to locate momd file for TDDToDo")
    }
    guard let model = NSManagedObjectModel(contentsOf: url) else {
      fatalError("Failed to load momd file for TDDToDo")
    }
    return model
  }()
  
  let persistentContainer: NSPersistentContainer
  var context: NSManagedObjectContext { persistentContainer.viewContext }
  
  static let `default`: StorageProvider = StorageProvider()
  
  init(storeType: StoreType = .persisted) {
    persistentContainer = NSPersistentContainer(name: "TDDToDo", managedObjectModel: Self.managedObjectModel)
    
    if storeType == .inMemory {
      persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    persistentContainer.loadPersistentStores { (_, error) in
      if let error = error {
        fatalError("Failed loading persistent stores with error: \(error.localizedDescription)")
      }
    }
  }
  
  func fetchPage<T: NSManagedObject>(_ pageIndex: Int, pageSize: Int, sortDescriptors: [NSSortDescriptor], for request: NSFetchRequest<T>, using context: NSManagedObjectContext) throws -> [T] {
    request.fetchLimit = pageSize
    request.fetchOffset = pageSize * pageIndex
    request.sortDescriptors = sortDescriptors
    
    return try context.fetch(request)
  }
}
