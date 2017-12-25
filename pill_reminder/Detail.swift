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
  
  var pill:Pill?
  
  var mainController : MainController?
  var pillId:Int?
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var posology: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var notificationSwitch: UISwitch!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    }
  override func viewWillAppear(_ animated: Bool) {
    
    name.text = pill?.pillName!
    posology.text = pill?.pillDescription!
  }
  
  override func viewWillDisappear(_ animated: Bool) {

  }


  @IBAction func didValidate(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }

  @IBAction func deleteCurrentPill(_ sender: Any) {
    PillController.deleteItem(pill!)
    navigationController?.popToRootViewController(animated: true)
  }
  
 
  
}
