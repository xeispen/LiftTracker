//
//  LiftTrackerTests.swift
//  LiftTrackerTests
//
//  Created by Peisen Xue on 7/29/17.
//  Copyright © 2017 Peisen Xue. All rights reserved.
//

import XCTest

@testable import LiftTracker


class LiftTrackerTests: XCTestCase {
    
    
    
    
    //MARK: Exercise class tests
    func testInitializationSucceeds() {
        
        let exercise1 = Exercise.init(name: "Deadlift", weight: 45, set: 1, rep: 1)
        XCTAssertNotNil(exercise1)
    }
    
}
