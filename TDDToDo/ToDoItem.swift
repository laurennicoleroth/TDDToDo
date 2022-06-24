//
//  ToDoItem.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/23/22.
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

public class ToDoItem : NSManagedObject, Codable {
  enum CodingKeys: CodingKey {
    case id, title, itemDescription, timeStamp, location, done
  }
  
  @NSManaged public var id: UUID
  @NSManaged public var title : String
  @NSManaged public var itemDescription : String?
  @NSManaged public var timeStamp : Date?
  @NSManaged public var location : Location?
  @NSManaged public var done : Bool
  
  public required convenience init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderConfigurationError.missingManagedObjectContext
    }
    
    self.init(context: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(UUID.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
    self.itemDescription = try container.decode(String.self, forKey: .itemDescription)
    self.timeStamp = try container.decode(Date.self, forKey: .timeStamp)
    self.location = try container.decode(Location.self, forKey: .location)
    self.done = try container.decode(Bool.self, forKey: .done)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(title, forKey: .title)
    try container.encode(itemDescription, forKey: .itemDescription)
    try container.encode(timeStamp, forKey: .timeStamp)
    try container.encode(location, forKey: .location)
    try container.encode(done, forKey: .done)
    
  }
  
}

extension StorageProvider {
  func findOrCreateToDoItem(id: UUID, title: String, itemDescription: String? = nil, timeStamp: Date, location: Location, done: Bool = false) -> ToDoItem {
    
    let request = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")

    request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
    
    if let toDoItem = try? persistentContainer.viewContext.fetch(request).first {
      
      return toDoItem
    } else {
      
      let toDoItem = ToDoItem(context: persistentContainer.viewContext)
      toDoItem.id = id
      toDoItem.title = title
      toDoItem.itemDescription = itemDescription
      toDoItem.location = location
      toDoItem.timeStamp = timeStamp
      
      do {
        try persistentContainer.viewContext.save()
      } catch {
        print("Error saving ToDoItem: \(error)")
      }
 
      return toDoItem
    }
  }
  
  func checkItem(_ item: ToDoItem) -> ToDoItem {
    item.done = true
    
    do {
      try persistentContainer.viewContext.save()
    } catch {
      print("Error checking ToDoItem as done: \(error)")
    }
    
    return item
  }
}
