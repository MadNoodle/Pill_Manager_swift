//
//  MainControllerExtensions.swift
//  pill_reminder
//
//  Created by Mathieu Janneau on 31/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//


import UIKit
import CoreData

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CustomCell
    let pill = pillItems[indexPath.row]
    cell.pillName.text = pill.pillName
    cell.posology.text = pill.pillDescription
    pillId = indexPath.row
    cell.button.addTarget(self, action: #selector(showDetail(sender:)), for: .touchUpInside)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pillItems.count
  }
  
  /**
   CallBackFunction when a collectionView cell button is clicked
   */
  @objc func showDetail( sender: UIButton) {
    
    //Grab Data from cell
    let cell = sender.superview?.superview as! CustomCell
    let indexPath = collectionView.indexPath(for: cell)
    // Pass data to detail Vc for loading infos from cell
    let detailVc = Detail(nibName: "Detail", bundle: nil)
    detailVc.pill = PillController.sendPill(from: pillItems, at: indexPath!)
    // Go to Detail Controller
    navigationController?.pushViewController(detailVc, animated: true)
    
  }
  
}
