//
//  TestMultipleSet.swift
//  sport
//
//  Created by Titouan Blossier on 11/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class TestMultipleSet : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
        BodyweightSquat(numberOfReps: 2, numberOfSets: 2)
                    ]
    
    var name: String = "Test"
    
    var pauseBetweenSports: Int = 4
}
