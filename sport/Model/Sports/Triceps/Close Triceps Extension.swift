//
//  Close Triceps Extension.swift
//  sport
//
//  Created by Titouan Blossier on 09/03/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class CloseTricepsExtension : SportWithReps {
    var numberOfReps: Int

    var intervalBetweenReps: Float = 2.7

    var isRecommended: Bool = true

    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }

    var name: String = "Close Triceps Extension"

    var specification: String = ""

    var numberOfSets: Int

    var numberOfImage: Int = 2

    var nameOfSoundFile: String = "Close Triceps Extension"

}
