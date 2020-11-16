//
//  Bodyweight Pull In Lying.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class BodyweightPullInLying : SportWithReps {
    var isRecommended: Bool = false
    
    var name: String = "Bodyweight Pull In"
    var intervalBetweenReps: Float = 3
    
    var specification: String = "Lying"
    var nameOfSoundFile: String = "BodyweightPullInLying"
    var numberOfReps: Int
    var numberOfImage: Int = 2
    var numberOfSets: Int
    
    required init(numberOfReps: Int, numberOfSets: Int) {
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
    }
}
