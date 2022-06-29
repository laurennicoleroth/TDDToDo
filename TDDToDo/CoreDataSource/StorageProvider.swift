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

extension NSManagedObject {
    class var entityName: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

protocol EntityCreating {
    var viewContext: NSManagedObjectContext { get }
    func createEntity<T: NSManagedObject>() -> T
}

extension EntityCreating {
    func createEntity<T: NSManagedObject>() -> T {
        T(context: viewContext)
    }
}

protocol CoreDataFetchResultsPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publisher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultsPublisher<T>
}

extension CoreDataFetchResultsPublishing {
    func publisher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultsPublisher<T> {
        return CoreDataFetchResultsPublisher(request: request, context: viewContext)
    }
}

protocol CoreDataDeleteModelPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publisher(delete request: NSFetchRequest<NSFetchRequestResult>) -> CoreDataDeleteModelPublisher
}

extension CoreDataDeleteModelPublishing {
    func publisher(delete request: NSFetchRequest<NSFetchRequestResult>) -> CoreDataDeleteModelPublisher {
        return CoreDataDeleteModelPublisher(delete: request, context: viewContext)
    }
}

protocol CoreDataSaveModelPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publisher(save action: @escaping Action) -> CoreDataSaveModelPublisher
}

extension CoreDataSaveModelPublishing {
    func publisher(save action: @escaping Action) -> CoreDataSaveModelPublisher {
        return CoreDataSaveModelPublisher(action: action, context: viewContext)
    }
}

protocol CoreDataStoring: EntityCreating, CoreDataFetchResultsPublishing, CoreDataDeleteModelPublishing, CoreDataSaveModelPublishing {
    var viewContext: NSManagedObjectContext { get }
}

final class StorageProvider : CoreDataStoring {
  var viewContext: NSManagedObjectContext {
      return self.persistentContainer.viewContext
  }
  
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
  
  static var `default`: CoreDataStoring = {
    return StorageProvider()
  }()
  
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
