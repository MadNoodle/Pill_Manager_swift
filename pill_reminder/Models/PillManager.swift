//
//  PillController.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 22/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/**
 This manager handles all the actions concerning Pills
 such as Creation, deletion, fetching in controllers,
 passing Pill object between controllers
 */
struct PillManager {
  //Container for Data
  static let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
  
  // Allows to load data in an Array
  static func loadData() -> [Pill] {
    var pillItems: [Pill] = []
    let request: NSFetchRequest<Pill> = Pill.fetchRequest()
    do {
      pillItems = (try managedObjectContext?.fetch(request))!
    } catch {
      print("loading error")
    }
    return pillItems
  }
  
  // Save new Pill Object in CoreData Stack
  static func save(_ pillName: String,
                   _ pillDesc: String,
                   _ pillNumber: String,
                   remind reminder: Date,
                   active state: Bool) {
    let pillItem = Pill(context: managedObjectContext!)
    
    //print dossier document pour controle
    let strToInt = Int64(pillNumber)
    pillItem.pillName = pillName
    pillItem.pillDescription = pillDesc
    pillItem.quantity = strToInt!
    pillItem.reminderDate = reminder
    pillItem.reminderState = state
    do {
      try managedObjectContext?.save()
    } catch {
      print("saving error")
      
    }
  }
  
  // Purge Core Data stack
  static func deleteAllItems() {
    let datas = loadData()
    for data in datas {
      managedObjectContext?.delete(data)
    }
    do {
      try managedObjectContext?.save()
    } catch {
      print("purging error")
    }
  }
  
  // Delete selected item
  static func deleteItem(_ object: Pill) {
    managedObjectContext?.delete(object)
    do {
      try managedObjectContext?.save()
    } catch {
      print("deleting error")
    }
  }
  
  // Use to pass a Pill object bettween Controllers
  static func sendPill(from pillItems: [Pill], at indexPath: IndexPath) -> Pill {
    let pill = pillItems[indexPath.row]
    return pill
  }
}
