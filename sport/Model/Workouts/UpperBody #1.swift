//
//  UpperBody.swift
//  sport
//
//  Created by Titouan Blossier on 09/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class UperBodyOne : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
        HipHingeHighPlank(numberOfSets: 1, timeOfTheExercise: 60),
        PushUps(numberOfSets: 1, timeOfTheExercise: 60),
        Plank(numberOfSets: 1, timeOfTheExercise: 60),
        SidePlankNeedle(numberOfSets: 1, timeOfTheExercise: 60),
        ArmCircle(numberOfReps: 30, numberOfSets: 3),
        BearCrawl(numberOfSets: 1, timeOfTheExercise: 60)
                                        ]
    
    var name: String = "Upper Body #1"
    
    var pauseBetweenSports: Int = 5
    
}
