//
//  ArmCircle.swift
//  sport
//
//  Created by Titouan Blossier on 13/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class ArmCircle : SportWithReps {
    var isRecommended: Bool = false
    
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 1
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Arm Circle"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 1
    
    var nameOfSoundFile: String = "Arm Circle"
    
    
}
