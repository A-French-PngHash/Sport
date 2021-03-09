//
//  UpperbodyWarmup.swift
//  sport
//
//  Created by Titouan Blossier on 09/03/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation

class UpperBodyWarmup : WorkoutProtocol {
    var sports: Array<SportProtocol> = [
        ArmCircle(numberOfReps: 30, numberOfSets: 3)
    ]

    var name: String = "Upper Body Warmup"

    var pauseBetweenSports: Int = 6

    var type: WorkoutType = .upperBody

    var fixed: Dictionary<Int, SportProtocol> = [:]
}
