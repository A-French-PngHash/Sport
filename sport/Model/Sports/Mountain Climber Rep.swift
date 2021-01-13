//
//  Mountain Climber Rep.swift
//  sport
//
//  Created by Titouan Blossier on 27/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class MountainClimberRep : SportWithReps {
    var isRecommended: Bool = false
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 1.5
    
    
    var intervalBetweenImages: Float = 0.3
    
    
    var name: String = "Mountain Climber"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 9
    
    var nameOfSoundFile: String = "Mountain Climber"

}
