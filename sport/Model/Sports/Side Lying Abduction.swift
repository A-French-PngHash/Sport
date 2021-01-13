//
//  Side Lying Abduction.swift
//  sport
//
//  Created by Titouan Blossier on 12/01/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class SideLyingAbduction : SportWithTimer {
    var timeOfTheExercise: Int

    var intervalBetweenImages: Float = 0.5

    required init(numberOfSets: Int, timeOfTheExercise: Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }

    var name: String = "Side Lying Abduction"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 2

    var nameOfSoundFile: String = "Side Lying Abduction"

}
