//
//  Seated In And Out.swift
//  sport
//
//  Created by Titouan Blossier on 26/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class SeatedInAndOut : SportWithReps {
    var isRecommended: Bool = false
    
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 2.5
    
    var name: String = "Seated In And Out"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "Seated In And Out"
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
