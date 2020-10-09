//
//  Session.swift
//  sport
//
//  Created by Titouan Blossier on 10/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation


class SportSession {
    var sports : Array<SportProtocol>
    
    private var currentSportIndex : Int = 0
    var reps : Int
    var sets : Int
    var totalReps : Int?
    var totalSets : Int
    var totalSessionTime : Float
    var currentState : WorkoutState
    var pauseBetweenSport : Int
    var timeUntilEndOfPause : Int
    var restTimer : Timer?
    
    // Hold the date in UNIX format when the sport started
    var sportBeganAt : Double?
    var timeUntilSportEnd : Int?
    
    var currentSport : SportProtocol {
        get {
            return sports[currentSportIndex]
        }
    }
    
    var nextSport : SportProtocol? {
        get {
            if sports.count - 1 == currentSportIndex {
                return nil
            }
            return sports[currentSportIndex + 1]
        }
    }
    
    var canGoNextSport : Bool{
        get {
            return nextSport != nil
        }
    }
    
    var canGoPreviousSport : Bool {
        get {
            return currentSportIndex != 0
        }
    }
    
    /*
     As described in SportProtocol.swift there are 2 different kind of sports.
     When this variable is equal to "t" then it is the "SportWithTimer" type else the variable is equal to "r" ("SportWithReps")
     */
    var currentSportType : String {
        get {
            return sportType(sport: currentSport)
        }
    }
    
    init(workout : WorkoutProtocol) {
        self.sports = workout.sports
        reps = 0
        sets = 1
        totalSessionTime = 0
        currentState = .doingWorkout
        totalSessionTime += Float(workout.pauseBetweenSports * workout.sports.count - 1)
        self.pauseBetweenSport = workout.pauseBetweenSports
        self.timeUntilEndOfPause = 0
        
        // We have to define this variable with a value defined without any use of a calculated property before setting it to something else
        self.totalSets = 0
        totalSets = currentSport.numberOfSets
        
        if let sportWithRep = currentSport as? SportWithReps{
            self.totalReps = sportWithRep.numberOfReps
        } else if let sportWithTimer = currentSport as? SportWithTimer{
            self.timeUntilSportEnd = sportWithTimer.timeOfTheExercise
        }
        calculateTotalSessionTime()
    }
    
    /*
     As described in SportProtocol.swift there are 2 different kind of sports.
     When this variable is equal to "t" then it is the "SportWithTimer" type else the variable is equal to "r" ("SportWithReps")
     */
    private func sportType(sport : SportProtocol) -> String{
        if let _ = sport as? SportWithReps {
            return "r"
        } else {
            return "t"
        }
    }
    
    private func calculateTotalSessionTime() {
        for i in sports {
            if let j = i as? SportWithReps {
                totalSessionTime += j.intervalBetweenReps * Float(j.numberOfReps) * Float(j.numberOfSets)
            } else {
                let j = i as! SportWithTimer
                totalSessionTime += Float(j.timeOfTheExercise * j.numberOfSets)
            }
        }
    }
    
    func secondsForEachImageCurrentSport() -> Float {
        var secondsForEachImage : Float = 0
        if let sport = currentSport as? SportWithReps {
            let interval = sport.intervalBetweenReps
            let numberImage = sport.numberOfImage
            secondsForEachImage = interval / Float(numberImage)
        } else if let sport = currentSport as? SportWithTimer {
            secondsForEachImage = Float(sport.intervalBetweenImages)
        }
        return secondsForEachImage
    }
    
    func rep() {
        //Called when we need to add one rep done
        reps += 1
        if reps == totalReps{
            if sets == totalSets {
                goNextSport()
            } else {
                
                sets += 1
                reps = 0
            }
        }
    }
    
    private func updateValuesForActualSport() {
        
        reps = 0
        sets = 1
        totalSets = currentSport.numberOfSets
        if let sport = currentSport as? SportWithReps {
            totalReps = sport.numberOfReps
        }
    }
    
    private func goNextSport(){
        if sports.count - 1 != currentSportIndex{
            currentState = .rest
            timeUntilEndOfPause = pauseBetweenSport
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RestReadyToBegin"), object: nil)
            
        }
    }
    
    func executeTransitionToNextSport() {
        guard sports.count - 1 != currentSportIndex else {
            return
        }
        
        if restTimer != nil{
            restTimer!.invalidate()
        }
        self.currentSportIndex += 1
        self.currentState = .anouncingWorkout
        self.updateValuesForActualSport()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RestEnded"), object: nil)
    }
    
    func executeTransitionToPreviousSport() {
        guard currentSportIndex  != 0 else {
            return
        }
        self.currentSportIndex -= 1
        self.currentState = .anouncingWorkout
        self.updateValuesForActualSport()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RestEnded"), object: nil)
    }
    
    func beginRest() {
        restTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true) { (timer) in
            self.timeUntilEndOfPause -= 1
            if self.timeUntilEndOfPause <= 0 {
                self.executeTransitionToNextSport()
            }
        }
    }
}
