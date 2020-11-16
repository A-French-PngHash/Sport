//
//  Plank Knees To Elbow.swift
//  sport
//
//  Created by Titouan Blossier on 26/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class PlankKneesToElbow : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 2.4
    
    var name: String = "Plank Knees To Elbow"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 4
    
    var nameOfSoundFile: String = "Plank Knees To Elbow"
    
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
