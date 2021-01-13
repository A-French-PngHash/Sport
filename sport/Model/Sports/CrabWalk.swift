//
//  CrabWalk.swift
//  sport
//
//  Created by Titouan Blossier on 12/01/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class CrabWalk : SportWithTimer {
    var timeOfTheExercise: Int

    var intervalBetweenImages: Float = 0.8

    required init(numberOfSets: Int, timeOfTheExercise: Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }

    var name: String = "Crab Walk"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 4

    var nameOfSoundFile: String = "Crab Walk"


}
