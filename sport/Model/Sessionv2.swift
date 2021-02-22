//
//  Sessionv2.swift
//  sport
//
//  Created by Titouan Blossier on 15/02/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation
import SwiftUI

/// This class is responsible for a session of one workout. It plays sounds when needed, go to the next sport and update its variables for display by the swiftui view.
/// It is implemented using state variables in such a way that it is easy for the view to retrieve data and display it.
class SessionV2 {
    let persistence : Persistence
    let workout : WorkoutProtocol

    /// Current number of reps to do for the current sport.
    @State var reps : Int

    /// Current number of sets to do for the current sport.
    @State var sets : Int

    /// Current set number.
    @State var setsDone : Int

    /// Number of reps done in the current set.
    @State var repsDone : Int

    @State var currentSport : SportProtocol

    @State var currentSportIndex : Int = -1

    init(workout : WorkoutProtocol, persistence : Persistence) {
        self.persistence = persistence
        self.workout = workout
    }

    /// Start the next sport by saying what it will be. Once the sport has been anounced, it will start incrementing the reps counter.
    func startNextSport() {
        currentSportIndex += 1
        self.currentSport = workout.sports[currentSportIndex]

        self.repsDone = 0
        self.setsDone = 0
        self.sets = self.currentSport.numberOfSets

        // Names of the sound files for the anouncment of the number of reps if the current sport is a SportWithReps. Otherwise, stay empty.

        // Sound names to play when anouncing.
        var soundNames = ["nowWeHave", currentSport.nameOfSoundFile, String(currentSport.numberOfSets), "series"]
        if let k = self.currentSport as? SportWithReps {
            self.reps = k.numberOfReps
            soundNames.append(String(reps))
            soundNames.append("repetitions")
        } else if let k = self.currentSport as? SportWithTimer {
            self.reps = 0
            soundNames.append(String(k.timeOfTheExercise))
            soundNames.append("seconds")
        }
        

        
    }
}
