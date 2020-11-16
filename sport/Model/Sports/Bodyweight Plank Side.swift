//
//  BodyweightPlankSide.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightPlankSide : SportWithTimer {
    var intervalBetweenImages: Float = 1
    var name: String = "Bodyweight Plank"
    var nameOfSoundFile: String = "BodyweightPlankSide"
    var numberOfImage: Int = 1
    var specification: String = "Side"
    var timeOfTheExercise: Int
    var numberOfSets: Int
    
    required init(numberOfSets: Int, timeOfTheExercise : Int) {
        self.timeOfTheExercise = timeOfTheExercise
        self.numberOfSets = numberOfSets
    }
}
