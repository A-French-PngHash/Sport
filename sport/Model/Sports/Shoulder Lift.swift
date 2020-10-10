//
//  Shoulder Lift.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
class ShoulderLift : SportWithTimer {
    var timeOfTheExercise: Int = 60
    
    var intervalBetweenImages: Float = 0.2
    
    required init(numberOfSets: Int) {
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Shoulder Lift"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 4
    
    var nameOfSoundFile: String

}
