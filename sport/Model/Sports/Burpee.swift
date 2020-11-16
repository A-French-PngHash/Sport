//
//  Bodyweight Burpee.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class Burpee : SportWithTimer{
    var timeOfTheExercise: Int = 30
    
    var intervalBetweenImages: Float = 0.3
    
    required init(numberOfSets: Int, timeOfTheExercise : Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }
    
    var name: String = "Burpee"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 21
    
    var nameOfSoundFile: String = "Burpee"
}

