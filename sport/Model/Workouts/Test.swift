//
//  Test.swift
//  sport
//
//  Created by Titouan Blossier on 16/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class Test : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
        ChairSitUps(numberOfReps: 10, numberOfSets: 2),
        Superman(numberOfSets: 2, timeOfTheExercise: 10),
        Burpee(numberOfSets: 1, timeOfTheExercise: 20)
                                        ]
    
    var name: String = "Test"
    
    var pauseBetweenSports: Int = 5
    var type : WorkoutType = .abs
    
}
