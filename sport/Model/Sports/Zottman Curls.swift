//
//  Zottman Curl.swift
//  sport
//
//  Created by Titouan Blossier on 25/11/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class ZottmanCurls : SportWithReps {
    var numberOfReps: Int = 20
    
    var intervalBetweenReps: Float = 4
    
    var isRecommended: Bool = true
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Zottman Curls"
    
    var specification: String = ""
    
    var numberOfSets: Int = 2
    
    var numberOfImage: Int = 4
    
    var nameOfSoundFile: String = "Zottman Curls"
    
    
}
