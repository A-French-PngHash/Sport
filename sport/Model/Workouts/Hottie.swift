//
//  Hottie.swift
//  sport
//
//  Created by Titouan Blossier on 09/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation


struct Hottie : WorkoutProtocol{
    let sports : Array<SportProtocol> = [TwistRussian(numberOfReps: 30,                                      numberOfSets: 1),
                                         BodyweightCrunchBicycle(numberOfReps: 30, numberOfSets: 1),
                                         BodyweightCrunchCrossBody(numberOfReps: 30, numberOfSets: 1),
                                         BodyweightButtUps(numberOfReps: 30, numberOfSets: 1),
                                         BodyweightHeelTouch(numberOfReps: 30, numberOfSets: 1),
                                         BodyweightPullInLying(numberOfReps: 30, numberOfSets: 1),
                                         BodyweightPlankSide(numberOfSets: 2, timeOfTheExercise: 60),
                                         BodyweightSquat(numberOfReps: 25, numberOfSets: 1)
    ]
    let name = "Workout #1"
    let pauseBetweenSports = 15
    let type : WorkoutType = .abs
}

