//
//  workoutType.swift
//  sport
//
//  Created by Titouan Blossier on 13/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

/*
 The rest case is not used for storing in the database, it is used by the training calculator to indicate a day where the user should rest
 */
enum WorkoutType : String{
    case arms, abs, rest
}

