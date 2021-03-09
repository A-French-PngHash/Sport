//
//  Biceps Upper Body Workout.swift
//  sport
//
//  Created by Titouan Blossier on 09/03/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class BicepsUpperBodyWorkout : WorkoutProtocol {

    var fixed: Dictionary<Int, SportProtocol> = [
        0 : PushUpsRecomended(numberOfReps: 20, numberOfSets: 2)
    ]

    var sports: Array<SportProtocol> = [
        Plank(numberOfSets: 1, timeOfTheExercise: 60),
        BearCrawl(numberOfSets: 1, timeOfTheExercise: 40),
        HammerCurls(numberOfReps: 2, numberOfSets: 10),
        PronatedCurls(numberOfReps: 2, numberOfSets: 10),
        RearDeltFlies(numberOfReps: 2, numberOfSets: 10),
        SupinatedBicepsCurls(numberOfReps: 2, numberOfSets: 10),
        ZottmanCurls(numberOfReps: 2, numberOfSets: 10)
    ]

    var name: String = "Biceps Upper Body Workout"

    var pauseBetweenSports: Int = 17

    var type: WorkoutType = .upperBody
}
