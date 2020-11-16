//
//  Leg Flutters.swift
//  sport
//
//  Created by Titouan Blossier on 27/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class LegFlutters : SportWithReps {
    var isRecommended: Bool = false
    
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 1
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfSets = numberOfSets
        self.numberOfReps = numberOfReps
    }
    
    var name: String = "Leg Flutters"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 4
    
    var nameOfSoundFile: String = "Leg Flutters"
    
    
}
