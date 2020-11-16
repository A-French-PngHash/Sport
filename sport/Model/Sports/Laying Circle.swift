//
//  Laying Circle.swift
//  sport
//
//  Created by Titouan Blossier on 26/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class LayingCircle : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 1.6
    
    var name: String = "Laying Circle"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 3
    
    var nameOfSoundFile: String = "Laying Circle"
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
