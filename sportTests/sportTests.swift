//
//  sportTests.swift
//  sportTests
//
//  Created by Titouan Blossier on 13/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import XCTest
import CoreData
@testable import sport

class sportTests: XCTestCase {
    var persistence : Persistence!
    // Used to execute queries to add items.
    let fakeCore = FakeCoreData.shared
    
    override func setUp() {
        persistence = Persistence(container: fakeCore.mockPersistantContainer)
        super.setUp()
    }
    
    override func 
    
    override func tearDown() {
        fakeCore.flushData()
        super.tearDown()
    }
    
    //MARK: - Training calculator test
    func test_givenNoExerciseWhenRetrievingPastFiveDaysThenRestEqualFive() {
        // Given no exercise
        
        // When retrieving past five days
        let result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 5)
        
        // Then rest equal 5 and other equal 0
        XCTAssertEqual(result.2, 5)
        XCTAssertEqual(result.1.count, 0)
        XCTAssertEqual(result.0.count, 0)
    }
}
