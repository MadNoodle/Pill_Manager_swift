//
//  Detail+editing.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 09/01/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

extension Detail: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  textField.isEnabled = false
    return true
  }
}
