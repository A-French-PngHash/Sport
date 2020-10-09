//
//  BodyweightPlankSide.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightPlankSide : SportWithReps {
    var name: String = "Bodyweight Plank"
    var nameOfSoundFile: String = "BodyweightPlankSide"
    var intervalBetweenReps: Float = 60
    var numberOfImage: Int = 1
    var specification: String = "Side"
    var numberOfReps: Int
    var numberOfSets: Int
    var needTimer = true
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
