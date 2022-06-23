//
//  Location.swift
//  TDDToDo
//
//  Created by Lauren N. Roth on 6/23/22.
//

import Foundation
import CoreLocation

struct Location : Equatable {
  static func == (lhs: Location, rhs: Location) -> Bool {
    if lhs.name != rhs.name {
      return false
    }
    if lhs.latitude == nil, rhs.latitude != nil {
      return false
    }
    if lhs.latitude != nil, rhs.latitude == nil {
      return false
    }
    
    if lhs.longitude == nil, rhs.longitude != nil {
      return false
    }
    if lhs.longitude != nil, rhs.longitude == nil {
      return false
    }
    
    if abs(lhs.longitude - rhs.longitude) > 0.000_000_1 {
      return false
    }
    if abs(rhs.longitude - lhs.longitude) > 0.000_000_1 {
      return false
    }
    
    return true
  }
  
  let name : String
  let latitude: Double
  let longitude: Double
  
  init(name: String, latitude: Double, longitude: Double) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
  }
}
