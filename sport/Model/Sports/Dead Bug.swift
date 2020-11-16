//
//  Dead Bug.swift
//  sport
//
//  Created by Titouan Blossier on 16/11/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class DeadBug : SportWithReps {
    var isRecommended: Bool = false
    
    var numberOfReps: Int = 20
    
    var intervalBetweenReps: Float = 3.2
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Dead Bug"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 4
    
    var nameOfSoundFile: String = "Leg Flutters"
    
}
