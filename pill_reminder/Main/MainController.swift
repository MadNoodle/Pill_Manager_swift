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

  var pillItems = [Pill]()
  var pillId: Int?

  @IBOutlet weak var collectionView: UICollectionView!
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

  @IBAction func purgeItems(_ sender: Any) {
    PillController.deleteAllItems()
    reloadData()
  }

  @IBAction func add(_ sender: Any) {
    let add = AddViewController(nibName: "Add", bundle: nil)
    navigationController?.pushViewController(add, animated: true)
  }

  fileprivate func reloadData() {
    pillItems = PillController.loadData()
    collectionView?.reloadData()
  }

}

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? CustomCell

    let pill = pillItems[indexPath.row]
    cell?.pillName.text = pill.pillName
    cell?.posology.text = pill.pillDescription
    pillId = indexPath.row
    cell?.button.addTarget(self, action: #selector(showDetail(sender:)), for: .touchUpInside)
    return cell!
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pillItems.count

  }
  @objc func showDetail( sender: UIButton) {
    guard let cell = sender.superview?.superview as? CustomCell else {
      return
    }

    let indexPath = collectionView.indexPath(for: cell)
    let detailVc = Detail(nibName: nil, bundle: nil)
    detailVc.pill = PillController.sendPill(from: pillItems, at: indexPath!)
    navigationController?.pushViewController(detailVc, animated: true)
  }

}
