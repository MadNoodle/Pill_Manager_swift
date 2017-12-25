//
//  DetailViewController.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 23/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBOutlet weak var pillNameField: UITextField!
  
  @IBOutlet weak var pillDescField: UITextField!
  
  @IBOutlet weak var PillNumberField: UITextField!
  
  @IBAction func addPillPressed(_ sender: Any) {
    
          guard let nameField = pillNameField,
            let newPillName = nameField.text else { return }
          guard let descField = pillDescField,
            let newPillDesc = descField.text else { return }
          PillController.save(newPillName, newPillDesc)
    navigationController?.popToRootViewController(animated: true)
  }
  
}
