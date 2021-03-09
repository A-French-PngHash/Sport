//
//  Triceps Upper Body Workout.swift
//  sport
//
//  Created by Titouan Blossier on 09/03/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class TricepsUpperBodyWorkout : WorkoutProtocol {

    var fixed: Dictionary<Int, SportProtocol> = [
        0 : PushUpsRecomended(numberOfReps: 20, numberOfSets: 2)
    ]

    var sports: Array<SportProtocol> = [
        OverheadTricepsExtension(numberOfReps: 10, numberOfSets: 2),
        Dips(numberOfReps: 10, numberOfSets: 2),
        TricepsKickback(numberOfReps: 10, numberOfSets: 2),
        BenchPress(numberOfReps: 10, numberOfSets: 2),
        BenchPressAlternating(numberOfReps: 10, numberOfSets: 2),
        CloseTricepsExtension(numberOfReps: 10, numberOfSets: 2)
    ]

    

    var name: String = "Triceps Upper Body Workout"

    var pauseBetweenSports: Int = 17

    var type: WorkoutType = .upperBody

}
