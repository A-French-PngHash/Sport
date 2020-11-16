//
//  Workouts.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

protocol WorkoutProtocol {
    var sports : Array<SportProtocol> { get }
    var name : String { get }
    var pauseBetweenSports : Int { get }
    var type : WorkoutType { get }
}

class Workouts{
    
    static let shared = Workouts()
    private init() {
        let hottie = Hottie()
        let upperBody1 = UperBodyOne()
        let upperBody2 = UpperBodyTwo()
        let test = Test()
        let secondAbsWorkout = AbsSecondWorkout()
        self.allWorkouts = [hottie, upperBody1, upperBody2, test, secondAbsWorkout]
        self.allWorkoutsNames = [hottie.name, upperBody1.name, upperBody2.name, test.name, secondAbsWorkout.name]
    }
    
    
    var allWorkoutsNames : Array<String>
    var allWorkouts : Array<WorkoutProtocol>
}
