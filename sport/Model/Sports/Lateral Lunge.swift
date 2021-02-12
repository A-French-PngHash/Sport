//
//  LateralLunge.swift
//  sport
//
//  Created by Titouan Blossier on 22/01/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class LateralLunge: SportWithReps {
    var numberOfReps: Int

    var intervalBetweenReps: Float = 3

    var isRecommended: Bool = true

    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfSets = numberOfSets
        self.numberOfReps = numberOfReps
    }

    var name: String = "Lateral Lunge"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 2

    var nameOfSoundFile: String = "Lateral Lunge"


}
