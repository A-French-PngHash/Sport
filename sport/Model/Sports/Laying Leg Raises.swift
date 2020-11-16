//
//  Laying Leg Raises.swift
//  sport
//
//  Created by Titouan Blossier on 26/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class LayingLegRaises : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 1.9
    
    var name: String = "Laying Leg Raises"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "Laying Leg Raises"
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
