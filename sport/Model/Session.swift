//
//  Session.swift
//  sport
//
//  Created by Titouan Blossier on 10/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation


class SportSession {
    
    var workoutType : WorkoutType
    var sports : Array<SportProtocol>
    
    private var currentSportIndex : Int = 0
    var reps : Int
    var sets : Int
    var totalReps : Int?
    var totalSets : Int
    
    /// Hold the number of seconds the session will last.
    var totalSessionTime : Float
    var currentState : WorkoutState
    var pauseBetweenSport : Int
    var timeUntilEndOfPause : Int
    var restTimer : Timer?
    
    /// Hold the date in UNIX format when the sport started.
    var sportBeganAt : Double?
    var timeOfTheExercise : Double?
    
    /// The date when the session was initialized.
    var sessionStartedAt : Date
    var workoutHasBeenSaved = false
    
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
    
    var currentSportIsRecommended : Bool {
        if let sport = currentSport as? SportWithReps {
            return sport.isRecommended
        }
        return false
    }
    
    // Calculated property for sport with timers
    var timeUntilSportEnd : Double? {
        get {
            guard let _ = currentSport as? SportWithTimer else {
                return nil
            }
            if currentState == .doingWorkout {
                return Double(timeOfTheExercise!) - (Date().timeIntervalSince1970 - sportBeganAt!)
            } else if currentState == .rest {
                return 0
            } else {
                return timeOfTheExercise
            }
        }
    }
    
    var sportWithTimerCompleted : Bool? {
        get {
            guard let _ = timeUntilSportEnd else {
                return nil
            }
            return timeUntilSportEnd! < 1
        }
    }
    
    init(workout : WorkoutProtocol) {
        self.sports = workout.sports.shuffled()
        self.sessionStartedAt = Date()
        reps = 0
        sets = 1
        totalSessionTime = 0
        currentState = .anouncingWorkout
        // The +7 is for the time spent speaking
        totalSessionTime += Float((workout.pauseBetweenSports + 7) * workout.sports.count - 1)
        self.pauseBetweenSport = workout.pauseBetweenSports
        self.timeUntilEndOfPause = 0
        
        workoutType = workout.type
        
        // We have to define this variable with a value defined without any use of a calculated property before setting it to something else
        self.totalSets = 0
        totalSets = currentSport.numberOfSets
        
        if let sportWithRep = currentSport as? SportWithReps{
            self.totalReps = sportWithRep.numberOfReps
        } else if let sportWithTimer = currentSport as? SportWithTimer{
            self.timeOfTheExercise = Double(sportWithTimer.timeOfTheExercise)
        }
        calculateTotalSessionTime()
        
        print("total :")
        print(totalSessionTime)
    }
    
    /// As described in SportProtocol.swift there are 2 different kind of sports.
    /// When this variable is equal to "t" then it is the "SportWithTimer" type else the variable is equal to "r" ("SportWithReps")/
    private func sportType(sport : SportProtocol) -> String {
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
        if reps >= totalReps!{
            setCompleted()
        }
    }
    
    func setCompleted() {
        // Sport begin at set 1
        saveIfNeeded()
        if sets == totalSets {
            if sports.count == currentSportIndex + 1 {
                currentState = .anouncingEnd
                NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "WorkoutEnded")))
            } else {
                goNextSport()
            }
        } else {
            currentState = .anouncingSet
            NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "SetEnded")))
        }
    }
    
    func startNextSet() {
        sets += 1
        reps = 0
        currentState = .doingWorkout
        sportBeganAt = Date().timeIntervalSince1970
    }
    
    private func updateValuesForActualSport() {
        reps = 0
        sets = 1
        totalSets = currentSport.numberOfSets
        if let sport = currentSport as? SportWithReps {
            totalReps = sport.numberOfReps
        } else if let sport = currentSport as? SportWithTimer {
            timeOfTheExercise = Double(sport.timeOfTheExercise)
        }
    }
    
    private func goNextSport(){
        if sports.count != currentSportIndex{
            currentState = .rest
            timeUntilEndOfPause = pauseBetweenSport
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RestReadyToBegin"), object: nil)
        }
    }
    
    /// Does everything to change immediatly the interface to the next sport
    ///
    /// Note that if the current sport had a recommended number of rep with no frequency imposed this will trigger a normal going to next sport which will trigger a rest.
    func executeTransitionToNextSport() {
        guard sports.count - 1 != currentSportIndex else {
            return
        }
        if currentSportIsRecommended && currentState != .rest{
            goNextSport()
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
    
    /// Check if the current workout has been saved and save it if not.
    ///
    /// Note that the user need to do at least half of the predicted time of the workout for it to save.
    private func saveIfNeeded() {
        if !workoutHasBeenSaved {
            let secondsElapsed = Date().timeIntervalSince1970 - sessionStartedAt.timeIntervalSince1970
            let percentage = Double(secondsElapsed) / Double(totalSessionTime)
            // When the user did half of the workout we can consider he did it.
            if percentage >= 0.5 {
                let persistence = AppDelegate.app.persistence
                persistence.insertWorkoutItem(date: sessionStartedAt, workoutType: workoutType)
                workoutHasBeenSaved = true
            }
        }
    }
}
