//
//  Biceps Upper Body Workout.swift
//  sport
//
//  Created by Titouan Blossier on 09/03/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class BicepsUpperBodyWorkout : WorkoutProtocol {

    var fixed: Dictionary<Int, SportProtocol> = [:]

    var sports: Array<SportProtocol> = [
        Plank(numberOfSets: 1, timeOfTheExercise: 60),
        BearCrawl(numberOfSets: 1, timeOfTheExercise: 40),
        HammerCurls(numberOfReps: 10, numberOfSets: 2),
        PronatedCurls(numberOfReps: 10, numberOfSets: 2),
        RearDeltFlies(numberOfReps: 10, numberOfSets: 2),
        SupinatedBicepsCurls(numberOfReps: 10, numberOfSets: 2),
        ZottmanCurls(numberOfReps: 10, numberOfSets: 2)
    ]

    var name: String = "Biceps Upper Body Workout"

    var pauseBetweenSports: Int = 17

    var type: WorkoutType = .upperBody
}
