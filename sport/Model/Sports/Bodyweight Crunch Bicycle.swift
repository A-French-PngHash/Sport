//
//  Bodyweight Crunch.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightCrunchBicycle : SportWithReps {
    var numberOfReps: Int
    var numberOfSets: Int
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    var numberOfImage: Int = 3
    var name: String = "Bodyweight Crunch"
    var intervalBetweenReps: Float = 2.4
    var specification: String = "Bicycle"
    var nameOfSoundFile: String = "BodyweightCrunchBicycle"
}
