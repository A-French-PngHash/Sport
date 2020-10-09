//
//  SportProtocol.swift
//  sport
//
//  Created by Titouan Blossier on 10/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

protocol SportProtocol{
    var name : String { get }
    var specification : String { get }
    var numberOfSets : Int { get }
    var numberOfImage : Int { get }
    var nameOfSoundFile : String { get }
    var needTimer : Bool { get } // not used for the momen
    

    
    init(numberOfReps : Int, numberOfSets : Int)
}

/*
 This type of exercise is when you have a given time (say 30 seconds) and you do as much reps as possible during this time.
 */
protocol SportWithTimer : SportProtocol{
    var timeOfTheExercise : Int { get }
    // Because we don't know how long a rep is we can't calculate the time between each images so it has to be given
    var intervalBetweenImages : Int { get }
}

/*
 This type is when you have to do a certain amount of reps and between each reps there is a time imposed and you have to stick with it.
 */
protocol SportWithReps : SportProtocol {
    var numberOfReps : Int { get }
    var intervalBetweenReps : Float { get }
}
