//
//  Lunges.swift
//  sport
//
//  Created by Titouan Blossier on 25/11/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class Lunges : SportWithTimer {
    var timeOfTheExercise: Int

    var intervalBetweenImages: Float = 0.6

    required init(numberOfSets: Int, timeOfTheExercise: Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }

    var name: String = "Lunges"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 4

    var nameOfSoundFile: String = "Lunges"

}
