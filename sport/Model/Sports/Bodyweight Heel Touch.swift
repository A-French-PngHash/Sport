//
//  Bodyweight Heel Touch.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightHeelTouch : SportWithReps {
    var isRecommended: Bool = false
    
    var numberOfReps: Int
    var numberOfSets: Int
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Bodyweight Heel Touch"
    var numberOfImage: Int = 4
    var intervalBetweenReps: Float = 3.3
    var nameOfSoundFile: String = "BodyweightHeelTouch"
    var specification: String = ""
    
    
}
