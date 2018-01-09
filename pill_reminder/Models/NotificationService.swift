//
//  NotificationService.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 27/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications

/**
 Handles all functionnlities for Notifications
 */
struct NotificationService {
  
  static let center = UNUserNotificationCenter.current()
  
  // configuration for User Notification center
  static func setupNotificationCenter() {
    // Request user authorization
    center.requestAuthorization(
    options: [.alert, .sound]) { (authorization: Bool, error: Error?) in
      if !authorization { print("why") }
      if error != nil { print(error!) }
    }
    // Add an action to the notification to confirm user has taken is pill
    let pillAction = UNNotificationAction(identifier: "takePill",
                                          title: "take Pill",
                                          options: [])
    // Sets the category
    let category = UNNotificationCategory(identifier: "Pill",
                                          actions: [pillAction],
                                          intentIdentifiers: [],
                                          options: [])
    // Tells the center to load the category notifications
    center.setNotificationCategories([category])
  }
  
  //  send notification to the center
  private static func addNotification(_ request: UNNotificationRequest) {
    // purge Notification center's stack and add new notifications
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error: Error?) in
      if let error = error {
        print("erreur:\(error.localizedDescription)")
      }
    })
  }
  
  // Remove Notification from center
  static func removeNotification(_ identifier: String) {
    center.removePendingNotificationRequests(withIdentifiers: [identifier])
  }
  
  // Get Notification from center
  private static func getNotifications() -> [String]{
    var notifications: [String] = []
    center.getPendingNotificationRequests(completionHandler: { requests in
      for request in requests {
        notifications.append(request.identifier)
      }
    })
    return notifications
  }
  
  // Sets the content of the notification alert that pops in Home
  private static func setContent(_ content: UNMutableNotificationContent, _ pillQuantity: String, _ pillName: String) {
    content.title = "N'oubliez pas vos medicaments"
    content.body = "Vous devez prendre \(pillQuantity) cachets de \(pillName)"
    content.sound = UNNotificationSound.default()
    content.categoryIdentifier = "Pill"
  }
  
  // Create a notification
  static func scheduleNotification(_ identifier: String,
                                   to date: Date,
                                   pillName: String,
                                   pillQuantity: String) {
    
    // Sets Date to the users timezone
    var calendar = Calendar.current
    calendar.timeZone = .current
    let componentsFromDate = calendar.dateComponents([.hour, .minute], from: date)
    // trigger
    let trigger = UNCalendarNotificationTrigger(dateMatching: componentsFromDate, repeats: true)
    // Content
    let content = UNMutableNotificationContent()
    setContent(content, pillQuantity, pillName)
    // request
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    addNotification(request)
    
  }
}
