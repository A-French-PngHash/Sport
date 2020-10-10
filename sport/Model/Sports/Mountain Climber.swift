//
//  Mountain Climber.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
class MountainClimber : SportWithTimer {
    var timeOfTheExercise: Int = 60
    
    var intervalBetweenImages: Float = 0.2
    
    required init(numberOfSets: Int) {
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Mountain Climber"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 9
    
    var nameOfSoundFile: String

}
