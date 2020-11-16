//
//  Side Plank Needle.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class SidePlankNeedle : SportWithTimer {
    var timeOfTheExercise: Int = 60
    
    var intervalBetweenImages: Float = 0.3
    
    required init(numberOfSets: Int, timeOfTheExercise : Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }
    
    var name: String = "Side Plank Needle"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 9
    
    var nameOfSoundFile: String = "Side Plank Needle"

}
