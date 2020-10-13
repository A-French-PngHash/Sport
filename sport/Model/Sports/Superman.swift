//
//  Superman.swift
//  sport
//
//  Created by Titouan Blossier on 11/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
class Superman : SportWithTimer {
    var timeOfTheExercise: Int
    
    var intervalBetweenImages: Float = 0.3
    
    required init(numberOfSets: Int, timeOfTheExercise: Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }
    
    var name: String = "Superman"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 12
    
    var nameOfSoundFile: String = "Superman"
}
