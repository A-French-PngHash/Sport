//
//  UpperBody.swift
//  sport
//
//  Created by Titouan Blossier on 09/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class UperBodyOne : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
                                        Burpee(numberOfSets: 1),
                                        PushUps(numberOfSets: 1),
                                        BodyweightHeelTouch(numberOfReps: 20, numberOfSets: 1),
                                        PushUps(numberOfSets: 1),
                                        PushUps(numberOfSets: 1),
                                        ]
    
    var name: String = "Uper Body"
    
    var pauseBetweenSports: Int = 5
    
}
