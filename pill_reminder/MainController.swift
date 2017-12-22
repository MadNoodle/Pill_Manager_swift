//
//  MainController.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 14/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import CoreData

class MainController: UIViewController{
  
  var pillItems = [Pill]()
  
  @IBOutlet weak var collectionView: UICollectionView!
  
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    reloadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.collectionView.reloadData()
  }
  
  @IBAction func purgeItems(_ sender: Any) {
    PillController.deleteAllItems()
    reloadData()
  }
  @IBAction func add(_ sender: Any) {
    
    let alert = UIAlertController(title: "New Pill",message: "Add a new pill", preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .default) {
      [unowned self] action in
      guard let nameField = alert.textFields?.first,
        let newPillName = nameField.text else { return }
      guard let descField = alert.textFields?.last,
        let newPillDesc = descField.text else { return }
      PillController.save(newPillName, newPillDesc)
      self.reloadData()
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",style: .default)
    
    alert.addTextField()
    alert.addTextField()
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    present(alert, animated: true)
  }
  
  fileprivate func reloadData() {
    pillItems = PillController.loadData()
    collectionView.reloadData()
  }
}

extension MainController: UICollectionViewDelegate,UICollectionViewDataSource
{
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CustomCell
    
    let pill = pillItems[indexPath.row]
    cell.pillName.text = pill.pillName
    cell.posology.text = pill.pillDescription
    cell.button.tag = indexPath.row
    cell.button.addTarget(self, action: #selector(deleteCurrent(sender:)), for: .touchUpInside)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pillItems.count
  }
  
  @objc func deleteCurrent( sender:UIButton){
    let indexpath = IndexPath(row: sender.tag, section: 0)
    let pillToDelete = pillItems[indexpath.row]
    PillController.deleteItem(pillToDelete)
    reloadData()
  }
}
