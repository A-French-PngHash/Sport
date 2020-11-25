//
//  Lunges.swift
//  sport
//
//  Created by Titouan Blossier on 25/11/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class Lunges : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 2
    
    var isRecommended: Bool = false
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Lunges"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 4
    
    var nameOfSoundFile: String = "Lunges"
    
    
}
