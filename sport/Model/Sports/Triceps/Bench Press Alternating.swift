//
//  BenchPressAlternating.swift
//  sport
//
//  Created by Titouan Blossier on 09/03/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class BenchPressAlternating : SportWithReps {
    var numberOfReps: Int

    var intervalBetweenReps: Float  = 3.4

    var isRecommended: Bool = true

    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }

    var name: String = "Bench Press Alternating"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 4

    var nameOfSoundFile: String = "Bench Press Alternating"


}
