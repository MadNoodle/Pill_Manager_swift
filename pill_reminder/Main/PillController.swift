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

struct PillController {
  static let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

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

  static func save(_ pillName: String,
                   _ pillDesc: String,
                   _ pillNumber: String,
                   remind reminder: Date,
                   active state: Bool) {
    let pillItem = Pill(context: managedObjectContext!)
    let strToInt = Int64(pillNumber)
    pillItem.pillName = pillName
    pillItem.pillDescription = pillDesc
    pillItem.quantity = strToInt!
    pillItem.reminderDate = reminder
    pillItem.reminderState = state
    do {
      try managedObjectContext?.save()
    } catch {}
  }

  static func deleteAllItems() {
    let datas = loadData()
    for data in datas {
      managedObjectContext?.delete(data)
    }
    do {
      try managedObjectContext?.save()
    } catch {}
  }

  static func deleteItem(_ object: Pill) {
    managedObjectContext?.delete(object)
    do {
      try managedObjectContext?.save()
    } catch {}
  }

  static func sendPill(from pillItems: [Pill], at indexPath: IndexPath) -> Pill {
    let pill = pillItems[indexPath.row]
    return pill
  }
}
