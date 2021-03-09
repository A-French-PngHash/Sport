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
    // Sports are shuffled. This dictionary allow to fix certain elements.
    // The sport array will be shuffled and then the sports inside this array will be inserted, starting from the closet to the begining of the lsit (index 0).
    // Key is index and value is sport to insert.
    // IF YOU PUT A SPORT IN HERE DONT PUT IT IN SPORTS ARRAY.
    var fixed : Dictionary<Int, SportProtocol> { get }
}

class Workouts{
    static let shared = Workouts()

    private init() {
        let hottie = Hottie()
        let upperBody1 = UperBodyOne()
        let upperBody2 = UpperBodyTwo()
        let lowerBody = LowerBodyWorkout()
        let secondAbsWorkout = AbsSecondWorkout()
        let newUpperBody = UpperBodyNewWorkout()
        let tricepsUpperBody = TricepsUpperBodyWorkout()
        let bicepsUpperBody = BicepsUpperBodyWorkout()
        let upperBodyWarmup = UpperBodyWarmup()
        self.allWorkouts = [hottie, upperBody1, upperBody2, secondAbsWorkout, newUpperBody, lowerBody, tricepsUpperBody, bicepsUpperBody, upperBodyWarmup]
        self.allWorkoutsNames = [hottie.name, upperBody1.name, upperBody2.name, secondAbsWorkout.name, newUpperBody.name, lowerBody.name, tricepsUpperBody.name, bicepsUpperBody.name, upperBodyWarmup.name]
    }
    
    
    var allWorkoutsNames : Array<String>
    var allWorkouts : Array<WorkoutProtocol>
}
