//
//  DetailViewController.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 23/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
  let detailVc = Detail(nibName: "Detail", bundle: nil)
  weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBOutlet weak var pillNameField: UITextField!
  @IBOutlet weak var pillDescField: UITextField!
  @IBOutlet weak var pillNumberField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var notificationSwitch: UISwitch!
  @IBAction func addPillPressed(_ sender: Any) {
          guard let nameField = pillNameField,
            let newPillName = nameField.text else { return }
          guard let descField = pillDescField,
            let newPillDesc = descField.text else { return }
    guard let pillField = pillNumberField,
            let newPillNumber = pillField.text else {return}
  let dateToRemind = datePicker.date
    if notificationSwitch.isOn {
      PillController.save(newPillName, newPillDesc, newPillNumber, remind: dateToRemind, active: true )
      NotificationService.scheduleNotification(newPillName,
                                               to: dateToRemind,
                                               pillName: newPillName,
                                               pillQuantity: newPillNumber)
    } else {
      PillController.save(newPillName, newPillDesc, newPillNumber, remind: dateToRemind, active: false )
    }
    navigationController?.popToRootViewController(animated: true)
  }
}
