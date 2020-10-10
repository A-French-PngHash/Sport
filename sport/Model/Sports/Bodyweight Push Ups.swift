//
//  Bodyweight Push Up.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightPushUps : SportWithTimer {
    var timeOfTheExercise: Int = 10
    
    var intervalBetweenImages: Int = 2
    
    var name: String = "Bodyweight Push Ups"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "BodyweightButtUps"
    
    required init(numberOfSets: Int) {
        self.numberOfSets = numberOfSets
    }
    
    
}
