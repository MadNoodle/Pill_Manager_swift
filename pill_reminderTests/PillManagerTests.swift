//
//  PillManagerTests.swift
//  pill_reminderTests
//
//  Created by Mathieu Janneau on 28/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import XCTest
@testable import pill_reminder

class PillManagerTests: XCTestCase {
  func testGivenCoreDataIsEmpty_WhenSavingData_ThenCoreDataIsPopulatedByPills() {
    // initialize the array
    var pill: [Pill] = []
    //Purge CoreData
    PillManager.deleteAllItems()
    //test function : saving data
    PillManager.save("pillule", "test_pillule", "3", remind: Date(), active: true)
    PillManager.save("pillule2", "test_pillule2", "2", remind: Date(), active: false)
    // Load Data
    pill = PillManager.loadData()
    // Assertions
    XCTAssert(pill[0].pillName == "pillule")
    XCTAssert(pill[0].pillDescription == "test_pillule")
    XCTAssert(pill[0].quantity == 3)
    XCTAssert(pill[0].reminderState == true)
    XCTAssert(pill[1].pillName == "pillule2")
    XCTAssert(pill[1].pillDescription == "test_pillule2")
    XCTAssert(pill[1].quantity == 2)
    XCTAssert(pill[1].reminderState == false)
  }

  func loadSampleData() {
    //Purge CoreData
    PillManager.deleteAllItems()
    //test function : saving data
    PillManager.save("pillule", "test_pillule", "3", remind: Date(), active: true)
    PillManager.save("pillule2", "test_pillule2", "2", remind: Date(), active: false)
  }

  func testGivenPillArrayIsEmpty_WhenLoadingData_ThenArrayIsPopulatedByPills() {
    // initialize the array
    var pills: [Pill] = []
    loadSampleData()
    // Load Data
    pills = PillManager.loadData()
    //Assertions
    XCTAssert(pills != [])
  }

  func testGivenCoreDataIsPopulated_WhenDeletingAllItems_ThenCoreDataIsEmpty() {
    // initialize the array
    var pill: [Pill] = []
    loadSampleData()
    //Reload Core Data in Array
    pill = PillManager.loadData()
    // Test function deleteAllitems
    PillManager.deleteAllItems()
    //Reload Data
    pill = PillManager.loadData()
    // Assertions
    XCTAssert(pill == [])
    XCTAssertEqual(pill, [])
  }

  func testGivenCoreDataIsNotEmpty_WhenDeletingAnItem_TheCoreDataHasOneItemLess() {
    var pills: [Pill] = []
    loadSampleData()
    pills = PillManager.loadData()
    PillManager.deleteItem(pills[0])
    pills = PillManager.loadData()
    XCTAssert(pills.count == 1)
    XCTAssert(pills[0].pillName == "pillule2")
  }

  func testGivenAnArrayOfPills_whenSendItem_thenReceivePillObject() {
    var pills: [Pill] = []
    loadSampleData()
    pills = PillManager.loadData()
    let indexPath = IndexPath(row: 0, section: 0)
    let receiver = PillManager.sendPill(from: pills, at: indexPath)
    XCTAssertEqual(receiver.pillName, "pillule")
  }

}
