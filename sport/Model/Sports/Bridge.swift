//
//  Bridge.swift
//  sport
//
//  Created by Titouan Blossier on 12/01/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class Bridge : SportWithReps {
    var numberOfReps: Int

    var intervalBetweenReps: Float = 4

    var isRecommended: Bool = false

    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }

    var name: String = "Bridge"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 2

    var nameOfSoundFile: String = "Bridge"


}
