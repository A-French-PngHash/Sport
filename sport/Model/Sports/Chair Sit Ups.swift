//
//  Chair Situp.swift
//  sport
//
//  Created by Titouan Blossier on 26/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class ChairSitUps : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 1.5
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Chair Sit Ups"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "Chair Sit Ups"
}
