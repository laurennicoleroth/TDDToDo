//
//  Location.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/23/22.
//

import Foundation
import CoreData
import MapKit
import SwiftUI


public class Location : NSManagedObject, Codable {
  enum CodingKeys: CodingKey {
    case id, name, latitude, longitude
  }
  
  @NSManaged public var id: UUID
  @NSManaged public var name : String
  @NSManaged public var latitude: Double
  @NSManaged public var longitude: Double
  
  public required convenience init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderConfigurationError.missingManagedObjectContext
    }
    
    self.init(context: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(UUID.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.latitude = try container.decode(Double.self, forKey: .latitude)
    self.longitude = try container.decode(Double.self, forKey: .longitude)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(latitude, forKey: .latitude)
    try container.encode(longitude, forKey: .longitude)
  }
}

extension StorageProvider {
  func findOrCreateLocation(id: UUID, name: String, latitude: Double, longitude: Double) -> Location {
    let request = NSFetchRequest<Location>(entityName: "Location")
  
    request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
    
    if let location = try? persistentContainer.viewContext.fetch(request).first {
      
      return location
    } else {
      
      let location = Location(context: persistentContainer.viewContext)
      location.id = id
      location.name = name
      location.latitude = latitude
      location.longitude = longitude
      
      do {
        try persistentContainer.viewContext.save()
      } catch {
        print("Error saving Location: \(error)")
      }
 
      return location
    }
  }
}
