//
//  Plank.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
class Plank : SportWithTimer {
    var timeOfTheExercise: Int = 60
    
    var intervalBetweenImages: Float = 1
    
    required init(numberOfSets: Int, timeOfTheExercise : Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }
    
    var name: String = "Plank"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 1
    
    var nameOfSoundFile: String = "Plank"

}
