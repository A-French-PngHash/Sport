//
//  BridgeWalkout.swift
//  sport
//
//  Created by Titouan Blossier on 22/01/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class BridgeWalkout : SportWithReps {
    var numberOfReps: Int

    var intervalBetweenReps: Float = 4

    var isRecommended: Bool = true

    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }

    var name: String = "Bridge Walkout"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 3

    var nameOfSoundFile: String = "Bridge Walkout"


}
