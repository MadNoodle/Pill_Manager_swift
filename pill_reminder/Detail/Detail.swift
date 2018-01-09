//
//  DetailViewController.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 23/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import CoreData

class Detail: UIViewController {
  
  //MARK: - PROPERTIES
  var pill: Pill?
  var dateRemind: Date?

  //MARK: - OUTLETS

  @IBOutlet weak var name: UITextField!
  @IBOutlet weak var posology: UITextField!
  @IBOutlet weak var numberOfPillPerDay: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var notificationSwitch: UISwitch!

  //MARK: - LIFECYCLE METHODS
  override func viewDidLoad() {
    super.viewDidLoad()
    name.delegate = self
    posology.delegate = self
    numberOfPillPerDay.delegate = self
    
    }

  override func viewWillAppear(_ animated: Bool) {
  showDataForSelectedItem()
  }

  
  //MARK: - ACTIONS
  @IBAction func editName(_ sender: UIButton) {
    edit(name)
  }
  @IBAction func editDescription(_ sender: Any) {
    edit(posology)
  }
  @IBAction func editPosology(_ sender: UIButton) {
    edit(numberOfPillPerDay)
  }
  @IBAction func didActivateReminder(_ sender: UISwitch) {
    if sender.isOn {
      // Update the Pill Object
      pill?.reminderDate = datePicker.date
      pill?.reminderState = true
      // Create a Notification
      NotificationService.scheduleNotification(name.text!,
                                               to: datePicker.date,
                                               pillName: name.text!,
                                               pillQuantity: numberOfPillPerDay.text!)
    } else {
      //If a notification has already been assigned to the Pill Object it is removed from the Center
      pill?.reminderState = false
      NotificationService.removeNotification((pill?.pillName)!)
    }
  }
  
  @IBAction func didValidate(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }

  @IBAction func deleteCurrentPill(_ sender: Any) {
    PillManager.deleteItem(pill!)
    navigationController?.popToRootViewController(animated: true)
  }
  
  // Populate View with data from Model
  private func showDataForSelectedItem() {
    name.text = pill?.pillName!
    posology.text = pill?.pillDescription!
    numberOfPillPerDay.text = String(describing: pill!.quantity)
    datePicker.date = pill!.reminderDate!
    notificationSwitch.isOn = pill!.reminderState
  }
  
  func edit(_ textfield: UITextField){
    textfield.isEnabled = true
    textfield.becomeFirstResponder()
  }
}
