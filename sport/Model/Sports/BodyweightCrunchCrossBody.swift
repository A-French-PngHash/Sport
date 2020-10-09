//
//  BodyweightCrunchCrossBody.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightCrunchCrossBody : SportWithReps{
    var numberOfReps: Int
    var needTimer = false
    var numberOfSets: Int
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    
    var numberOfImage: Int = 4
    var name: String = "Bodyweight Crunch"
    var nameOfSoundFile: String = "BodyweightCrunchCrossBody"
    var intervalBetweenReps: Float = 4.5
    
    var specification: String = "Cross Body"
    
    
}
