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
                                        BodyweightPushUps(numberOfSets: 1),
                                        BodyweightPushUps(numberOfSets: 1),
                                        BodyweightPushUps(numberOfSets: 1),
                                        ]
    
    var name: String = "Uper Body"
    
    var pauseBetweenSports: Int = 5
    
}
