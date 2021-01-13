//
//  Lower Body Workout.swift
//  sport
//
//  Created by Titouan Blossier on 12/01/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class LowerBodyWorkout : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
        LegFlutters(numberOfReps: 30, numberOfSets: 1),
        Bridge(numberOfReps: 15, numberOfSets: 1),
        SingleLegBridge(numberOfReps: 10, numberOfSets: 2),
        Lunges(numberOfSets: 1, timeOfTheExercise: 60),
        CrabWalk(numberOfSets: 1, timeOfTheExercise: 60),
        GluteusKickback(numberOfSets: 2, timeOfTheExercise: 40),
        KneelingSquat(numberOfSets: 1, timeOfTheExercise: 60),
        PulsingSquat(numberOfSets: 1, timeOfTheExercise: 60),
        SideLyingAbduction(numberOfSets: 2, timeOfTheExercise: 45),
        SquatHoldAbduction(numberOfSets: 1, timeOfTheExercise: 60)
    ]

    var name: String = "Lower Body"

    var pauseBetweenSports: Int = 10

    var type: WorkoutType = .lowerBody
}
