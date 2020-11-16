//
//  SportProtocol.swift
//  sport
//
//  Created by Titouan Blossier on 10/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

protocol SportProtocol{
    /// Name of the sport.
    var name : String { get }
    /// If the sport name is kind of generic and this sport is a special type/variation of the original sport, this field is the name of this variation.
    var specification : String { get }
    /// The number of sets. Between each steps there is a little pause of a few seconds.
    var numberOfSets : Int { get }
    /// Number of image, used to show the user which workout to do.
    var numberOfImage : Int { get }
    /// Used for audio announcments.
    var nameOfSoundFile : String { get }
}

/// This type of exercise is when you have a given time (say 30 seconds) and you do as much reps as possible during this time.
protocol SportWithTimer : SportProtocol {
    /// Used to know when to end the sport as we have no specified number of reps.
    var timeOfTheExercise : Int { get }
    /// Because we don't know how long a rep is, we can't calculate the time between each images so it has to be given.
    var intervalBetweenImages : Float { get }
    init(numberOfSets : Int, timeOfTheExercise : Int)
}

///This type is when you have to do a certain amount of reps and between each reps there is a time imposed and you have to stick with it.
protocol SportWithReps : SportProtocol {
    var numberOfReps : Int { get }
    var intervalBetweenReps : Float { get }
    
    /// Define if the number of reps is a recommended number of reps or if it is imposed with a number said between each rep.
    ///
    /// If it is set to true then the intervalBetweenReps variable is used only to calculate the time between each image.
    var isRecommended : Bool { get }
    init(numberOfReps : Int, numberOfSets : Int)
}
