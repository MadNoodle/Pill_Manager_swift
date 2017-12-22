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

struct PillController{
  
  static let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  static func loadData() -> [Pill]{
    var pillItems : [Pill] = []
    let request : NSFetchRequest<Pill> = Pill.fetchRequest()
    
    do{
      pillItems = try managedObjectContext.fetch(request)
    } catch {
      print("error \(error.localizedDescription)")
    }
    return pillItems
  }
  
  static func save(_ pillName : String, _ pillDesc: String){
    let pillItem = Pill(context: managedObjectContext)
    pillItem.pillName = pillName
    pillItem.pillDescription = pillDesc
    
    do{
      try managedObjectContext.save()
    } catch {
      print("error \(error.localizedDescription)")
    }
  }
  
  static func deleteAllItems(){
    let datas = loadData()
    for data in datas {
     managedObjectContext.delete(data)
    }
    do{
      try managedObjectContext.save()
    } catch {
      print("error: \(error.localizedDescription)")
    }
  }
  
  static func deleteItem(_ object: Pill){
    managedObjectContext.delete(object)
  
  do{
  try managedObjectContext.save()
  } catch {
  print("error: \(error.localizedDescription)")
  }
  
  }
}
