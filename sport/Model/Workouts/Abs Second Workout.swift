//
//  Abs Second Workout.swift
//  sport
//
//  Created by Titouan Blossier on 27/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class AbsSecondWorkout : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
        ChairSitUps(numberOfReps: 10, numberOfSets: 2),
        VUps(numberOfReps: 20, numberOfSets: 1),
        ToeTouches(numberOfReps: 20, numberOfSets: 1),
        Crucifixes(numberOfReps: 20, numberOfSets: 1),
        TwistRussian(numberOfReps: 15, numberOfSets: 2),
        BodyweightHeelTouch(numberOfReps: 20, numberOfSets: 1),
        PlankKneesToElbow(numberOfReps: 10, numberOfSets: 1),
        MountainClimberRep(numberOfReps: 20, numberOfSets: 1),
        LayingCircle(numberOfReps: 10, numberOfSets: 2),
        DeadBug(numberOfReps: 20, numberOfSets: 1),
        SideBend(numberOfReps: 20, numberOfSets: 2)
    ]
    
    
    var name: String = "Abs Second Workout"
    
    var pauseBetweenSports: Int = 8
    
    var type: WorkoutType = .abs
    
    
}
