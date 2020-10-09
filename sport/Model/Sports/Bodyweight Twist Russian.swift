//
//  Bodyweight Twist.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightTwist : SportWithReps {
    var specification: String = "Russian"
    var name: String = "Bodyweight Twist"
    var intervalBetweenReps: Float = 3
    var numberOfImage: Int = 3
    var nameOfSoundFile: String = "BodyweightTwistRussian"
    var needTimer = false
    var numberOfReps: Int
    
    var numberOfSets: Int
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
