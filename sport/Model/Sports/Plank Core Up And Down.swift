//
//  Plank Core Up And Down.swift
//  sport
//
//  Created by Titouan Blossier on 26/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class PlankCoreUpAndDown : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 1.4
    
    var name: String = "Plank Core Up & Down"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "Plank Core Up And Down"
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
