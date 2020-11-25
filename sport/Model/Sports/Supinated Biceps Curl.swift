//
//  Supinated Biceps Curl.swift
//  sport
//
//  Created by Titouan Blossier on 19/11/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class SupinatedBicepsCurls : SportWithReps {
    var numberOfReps: Int
    
    var intervalBetweenReps: Float = 2
    
    var isRecommended: Bool = true
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Supinated Biceps Curls"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 2
    
    var nameOfSoundFile: String = "Supinated Biceps Curls"
    
    
}
