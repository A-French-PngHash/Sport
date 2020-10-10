//
//  Hip Hinge High Plank.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
class HipHingeHighPlank : SportWithTimer {
    var timeOfTheExercise: Int = 60
    
    var intervalBetweenImages: Float = 0.2
    
    required init(numberOfSets: Int) {
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Hip Hinge High Plank"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 21
    
    var nameOfSoundFile: String

}
