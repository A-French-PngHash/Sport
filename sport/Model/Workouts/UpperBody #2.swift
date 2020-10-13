//
//  UpperBody #2.swift
//  sport
//
//  Created by Titouan Blossier on 11/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class UpperBodyTwo : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
        Superman(numberOfSets: 1, timeOfTheExercise: 60),
        Burpee(numberOfSets: 1, timeOfTheExercise: 60),
        ShoulderLift(numberOfSets: 1, timeOfTheExercise: 60),
        ReverseFly(numberOfSets: 1, timeOfTheExercise: 60),
        MountainClimber(numberOfSets: 1, timeOfTheExercise: 60)
                                        ]
    
    var name: String = "Upper Body #2"
    
    var pauseBetweenSports: Int = 5
    
}
