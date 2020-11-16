//
//  V Ups.swift
//  sport
//
//  Created by Titouan Blossier on 26/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class VUps : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 2.5
    
    var name: String = "V Ups"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "V Ups"
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
