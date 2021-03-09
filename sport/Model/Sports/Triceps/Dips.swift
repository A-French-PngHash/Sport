//
//  Dips.swift
//  sport
//
//  Created by Titouan Blossier on 09/03/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class Dips : SportWithReps {
    var numberOfReps: Int

    var intervalBetweenReps: Float = 3.2

    var isRecommended: Bool = true

    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }

    var name: String = "Dips"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 2

    var nameOfSoundFile: String = "Dips"


}
