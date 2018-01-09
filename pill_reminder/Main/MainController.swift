//
//  MainController.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 14/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import CoreData

class MainController: UIViewController {
  
  // MARK: - PROPERTIES & OUTLETS
  var pillItems = [Pill]()
  var pillId: Int?
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: - LIFECYCLE METHODS
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    reloadData()
  }

  override func viewWillAppear(_ animated: Bool) {
    reloadData()
  }

  override func viewDidAppear(_ animated: Bool) {
    self.collectionView.reloadData()
  }

  // MARK: - ACTIONS
  @IBAction func purgeItems(_ sender: Any) {
    PillManager.deleteAllItems()
    reloadData()
  }

  @IBAction func add(_ sender: Any) {
    let add = AddViewController(nibName: "Add", bundle: nil)
    navigationController?.pushViewController(add, animated: true)
  }

  fileprivate func reloadData() {
    pillItems = PillManager.loadData()
    collectionView?.reloadData()
  }

}

