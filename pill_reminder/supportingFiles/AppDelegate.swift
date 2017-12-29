//
//  AppDelegate.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 14/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    UNUserNotificationCenter.current().requestAuthorization(
    options: [.alert, .sound]) { (authorization: Bool, error: Error?) in
      if !authorization { print("why") }
      if error != nil { print(error!) }
    }
    let pillAction = UNNotificationAction(identifier: "takePill",
                                          title: "Confirm you have taken your pill",
                                          options: [])
    let category = UNNotificationCategory(identifier: "Pill",
                                          actions: [pillAction],
                                          intentIdentifiers: [],
                                          options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
 }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
   self.saveContext()
  }

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
      /*
       The persistent container for the application. This implementation
       creates and returns a container, having loaded the store for the
       application to it. This property is optional since there are legitimate
       error conditions that could cause the creation of the store to fail.
      */
      let container = NSPersistentContainer(name: "pill_reminder")
      container.loadPersistentStores(completionHandler: { (_, error) in
          if let error = error as NSError? {

              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.

              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
}
