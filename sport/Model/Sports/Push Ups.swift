//
//  Bodyweight Push Up.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class PushUps : SportWithTimer {
    var timeOfTheExercise: Int = 10
    
    var intervalBetweenImages: Float = 0.3
    
    var name: String = "Push Up"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 10
    
    var nameOfSoundFile: String = "Push Up"
    
    required init(numberOfSets: Int, timeOfTheExercise : Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }
}
