//
//  Bodyweight Squat.swift
//  sport
//
//  Created by Titouan Blossier on 08/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightSquat : SportWithReps
 {
    var name: String = "Bodyweight Squat"
    
    var intervalBetweenReps: Float = 3.3
    
    var specification: String = ""
    
    var numberOfReps: Int
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "BodyweightSquat"
    
    var needTimer: Bool = false
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    
}
