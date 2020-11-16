//
//  Bodyweight Butt ups.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightButtUps : SportWithReps {
    var isRecommended: Bool = false
    
    var numberOfReps: Int
    var numberOfSets: Int
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var numberOfImage: Int = 2
    var name: String = "Bodyweight Butt Ups"
    var nameOfSoundFile: String = "BodyweightButtUps"
    var intervalBetweenReps: Float = 3.8
    
    var specification: String = ""
    
    
}
