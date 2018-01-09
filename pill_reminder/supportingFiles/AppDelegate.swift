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
    
    // Set status bar to white font
    UIApplication.shared.statusBarStyle = .lightContent
    // NAvbar parameters
    setupNavBar()
    // Launch UNNotificationsCenter from Service
    NotificationService.setupNotificationCenter()
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
              
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
  
  fileprivate func setupNavBar() {
    // Initialize NavigationContoller
    let navigationBarAppearance = UINavigationBar.appearance()
    navigationBarAppearance.barTintColor = #colorLiteral(red: 0, green: 0.7841242552, blue: 0.7883579135, alpha: 1)
    navigationBarAppearance.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
  }
}
