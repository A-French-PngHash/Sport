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
        super.setUp()
        persistence = Persistence(container: fakeCore.mockPersistantContainer)
    }
    
    override func tearDown() {
        fakeCore.flushData()
        super.tearDown()
    }

    //MARK: - Training calculator test - Retrieveing past five days
    
    func testGivenNoExerciseWhenRetrievingPastFiveDaysThenRestEqualFour() {
        // Given no exercise.
        
        // When retrieving past five days.
        let result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 5, persistence: persistence)
        
        // Then rest equal 4 and other equal 0.
        XCTAssertEqual(result.3, 4) // Rest
        XCTAssertEqual(result.1.count, 0) // Abs
        XCTAssertEqual(result.0.count, 0) // Arms
    }
    
    func testGivenThreeArmWhenRetrievingPastFiveDaysThenArmEqualThreeAndRestOne(){
        // Given three arm exercise during the last 5 days, each different
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 1), type: .arms)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 2), type: .arms)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 3), type: .arms)

        // When retrieving past five days
        let result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 5, persistence: persistence)
        
        // Then arm equal 3 and rest equal 1
        XCTAssertEqual(result.3, 1) // Rest
        XCTAssertEqual(result.1.count, 0) // Abs
        XCTAssertEqual(result.0.count, 3) // Arms
    }
    
    func testGivenThreeArmAndOneAbsWhenRetrievingPastFiveDaysThenArmEqualThreeAndAbsOneAndRestZero(){
        // Given three arm and one abs exercise during the last 5 days, each day different
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 1), type: .arms)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 2), type: .arms)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 3), type: .abs)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 4), type: .arms)

        // When retrieving past five days
        let result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 5, persistence: persistence)
        
        // Then arm equal 3, abs 1 and rest 0
        XCTAssertEqual(result.3, 0) // Rest
        XCTAssertEqual(result.1.count, 1) // Abs
        XCTAssertEqual(result.0.count, 3) // Arms
    }
    
    func testGivenOneExerciseTodayWhenRetrievingPastFiveDaysThenRestEqualFour(){
        // Given one exercise today
        fakeCore.insertWorkoutItem(date: Date(), type: .abs)
        
        // When retrieving past five days
        let result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 5, persistence: persistence)

        // Then rest equal 4 and other 0
        XCTAssertEqual(result.3, 4) // Rest
        XCTAssertEqual(result.1.count, 0) // Abs
        XCTAssertEqual(result.0.count, 0) // Arms
    }
    
    func testGivenThreeArmAndTwoAbsButOneTodayWhenRetrievingPastFiveDaysThenArmEqualThreeAndAbsOneAndRestZero(){
        // Given three arm and two abs workout during the last 5 days but one abs today, each day different.
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 0), type: .abs)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 1), type: .arms)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 2), type: .arms)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 3), type: .abs)
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 4), type: .arms)

        // When retrieving past five days.
        let result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 5, persistence: persistence)
        
        // Then arm equal 3, abs 1 and rest 0.
        XCTAssertEqual(result.3, 0) // Rest
        XCTAssertEqual(result.1.count, 1) // Abs
        XCTAssertEqual(result.0.count, 3) // Arms
    }
    
    func testGivenWorkoutSixDaysAgoWhenRetrievingPastFiveDaysThenRestFour() {
        // Given workout six days ago.
        fakeCore.insertWorkoutItem(date: Date.dateXDaysAgo(x: 6), type: .abs)

        // When retrieving past five days.
        let result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 5, persistence: persistence)
        
        // Then arm rest equal 4 and other 0.
        XCTAssertEqual(result.3, 4) // Rest
        XCTAssertEqual(result.1.count, 0) // Abs
        XCTAssertEqual(result.0.count, 0) // Arms
    }
    
    //MARK: - Training Calculator Test - Recommended Workout


    func testGivenNoWorkoutWhenGettingRecommendedThenIsNotRest() {
        // Given no workout.
        let rest = 2
        let arm = 0
        let abs = 0

        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)

        // Then is not rest
        XCTAssertNotEqual(recomended, .rest)
    }

    func testGivenWorkoutTodayWhenGettingRecommendedThenIsAlreadyWorkout() {
        // Given workout today.
        fakeCore.insertWorkoutItem(date: Date(), type: .abs)
        // We can put random values here which should not affect anything.
        let rest = 0
        let arm = 0
        let abs = 0

        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)

        // Then is already workout.
        XCTAssertEqual(recomended, .alreadyWorkout)
    }

    func testGivenOneArmsAndAbsWhenGettingRecommendedThenIsRest() {
        // Given one upperBody and one abs
        let rest = 0
        let arm = 1
        let abs = 1

        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)

        // Then is rest.
        XCTAssertEqual(recomended, .rest)
    }

    func testGivenOneArmWhenGettingRecommendedThenIsAbs() {
        // Given one arm.
        let rest = 1
        let arm = 1
        let abs = 0

        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)

        // Then is abs.
        XCTAssertEqual(recomended, .abs)
    }

    func testGivenOneAbsWhenGettingRecommendedThenIsArm() {
        // Given one arm.
        let rest = 1
        let arm = 0
        let abs = 1

        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)

        // Then is abs.
        XCTAssertEqual(recomended, .arms)
    }

    /*


    
    func testGivenTwoArmsOneAbsAndOneRestWhenGettingRecommendedThenIsAbs() {
        // Given two upperBody and one abs and one rest
        let rest = 1
        let arm = 2
        let abs = 1
        
        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)
        
        // Then is abs.
        XCTAssertEqual(recomended, .abs)
    }
    
    func testGivenOneArmAndTwoAbsAndOneRestWhenGettingRecommendedThenIsArm() {
        // Given one arm and tow abs and one rest
        let rest = 1
        let arm = 1
        let abs = 2
    
        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)
        
        // Then is arms.
        XCTAssertEqual(recomended, .arms)
    }
    

    
    func testGivenOneArmsAndThreeRestWhenGettingRecommendedThenIsAbs() {
        // Given two arms and one abs and one rest
        let rest = 3
        let arm = 1
        let abs = 0
        
        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)
        
        // Then is abs.
        XCTAssertEqual(recomended, .abs)
    }
    
    func testGivenOneAbsAndThreeRestWhenGettingRecommendedThenIsArm() {
        // Given one arm and tow abs and one rest.
        let rest = 3
        let arm = 0
        let abs = 1
    
        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)
        
        // Then is arms.
        XCTAssertEqual(recomended, .arms)
    }
    
    func testGivenThreeArmAndOneAbsWhenGettingRecommendedThenIsRest() {
        // Given Three arm and one abs.
        let rest = 0
        let arm = 3
        let abs = 1
    
        // When getting recommended workout.
        let recomended = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: arm, absWorkout: abs, restWorkout: rest, persistence: persistence)
        
        // Then is rest.
        XCTAssertEqual(recomended, .rest)
    }
 */
}
