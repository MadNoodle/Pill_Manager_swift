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

struct NotificationService {
  static let center = UNUserNotificationCenter.current()
  
  static func setupNotificationCenter() {
    center.requestAuthorization(
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
   center.setNotificationCategories([category])
  }
  
  static func scheduleNotification(_ identifier: String,
                                   to date: Date,
                                   pillName: String,
                                   pillQuantity: String) {

    var calendar = Calendar.current
    calendar.timeZone = .current
    let componentsFromDate = calendar.dateComponents([.hour, .minute], from: date)
    let trigger = UNCalendarNotificationTrigger(dateMatching: componentsFromDate, repeats: true)
    let content = UNMutableNotificationContent()

    content.title = "N'oubliez pas vos medicaments"
    content.body = "Vous devez prendre \(pillQuantity) cachets de \(pillName)"
    content.sound = UNNotificationSound.default()
    content.categoryIdentifier = "Pill"

    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error: Error?) in
      if let error = error {
        print("erreur:\(error.localizedDescription)")
      }
    })

    center.getPendingNotificationRequests(completionHandler: { requests in
      for request in requests {
        print("NOTIF : \(request.identifier)")
      }
    })
  }

  static func removeNotification(_ identifier: String) {
    center.removePendingNotificationRequests(withIdentifiers: [identifier])
  }
}
