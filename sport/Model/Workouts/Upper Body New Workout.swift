//
//  Upper Body New Workout.swift
//  sport
//
//  Created by Titouan Blossier on 17/11/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

struct UpperBodyNewWorkout : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
        PushUps(numberOfSets: 1, timeOfTheExercise: 30),
        Plank(numberOfSets: 1, timeOfTheExercise: 60),
        BearCrawl(numberOfSets: 1, timeOfTheExercise: 40),
        ArmCircle(numberOfReps: 30, numberOfSets: 3),
        OverheadTricepsExtension(numberOfReps: 20, numberOfSets: 2),
        HammerCurls(numberOfReps: 20, numberOfSets: 2),
        PronatedCurls(numberOfReps: 20, numberOfSets: 2),
        RearDeltFlies(numberOfReps: 20, numberOfSets: 2),
        SupinatedBicepsCurls(numberOfReps: 20, numberOfSets: 2),
        ZottmanCurls(numberOfReps: 20, numberOfSets: 2)
    ]
     
    
    var name: String = "Upper Body Second Workout"
    
    var pauseBetweenSports: Int = 17
    
    var type: WorkoutType = .arms
    
}
