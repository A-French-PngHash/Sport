//
//  Rear Delt Flies.swift
//  sport
//
//  Created by Titouan Blossier on 17/11/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class RearDeltFlies : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 2
    
    var isRecommended: Bool = true
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfSets = numberOfSets
        self.numberOfReps = numberOfReps
    }
    
    var name: String = "Rear Delt Flies"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "Rear Delt Flies"
}
