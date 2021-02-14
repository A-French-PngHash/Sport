//
//  TrainingCalculator.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class TrainingCalculator {
    /*
     For the moment this training calculator only works with 1 training programm. It works on 5 days :
     1 : abs, 2 : arms, 3 : abs, 4 : arms, 5 : rest
    
     If we sum up it means that on 5 days you should do 2 arms, 2 abs and 1 rep.
     
     To recommend a workout, the programm will look at the past 5 days that will maybe give :
     abs, arms, rest, abs
     You need to do 2 arms per 5 days and the programm see that only one has been done so it recommend you to do arms today.
     
     This is basically how the recomendation work. There are a lots of little tweaks that were not explained here but it is still the main principle.
     */

    
    let armsGoal = 1
    let absGoal = 1
    /// Running is not mandatory.
    let possibleRun = 1
    let restGoal = 1
    var persistence : Persistence

    /// Text to display to the user depending on the workout being recomended.
    static let textToDisplay : Dictionary<WorkoutType, String> = [
        .abs : "Abs is what we recommend you today !",
        .arms : "We recommend you to do your arm workout today !",
        .rest : "You've been active for the past couple days so today take a break, relax yourself, rest !",
        .alreadyWorkout : "Great ! You've already workout today, rest for tomorow !"
    ]

    init(persistence : Persistence) {
        /// This init allows for testing with a custom database.
        self.persistence = persistence

    }

    /**
     Get the workouts under array form for the last x days.
     
     - Remark : In the returned arrays, there is a maximum of one workout per day per array. The function return in position 0 the number of arm workout, position 1 the number of abs and 2 the number of rest.
     
     - requires : x must be less than 28 else it could cause problem.
     
     - parameter x : The number of day.
     - parameter persistence : Used for unit testing to define a custom persistence class. No need to specify this argument for the production code.
     */
    func getSportArrayForLastXDays(x : Int) -> (Array<WorkoutData>, Array<WorkoutData>, Array<WorkoutData>, Int){
        
        if x >= 28 {
            fatalError("This situation will cause problems.")
        }
        
        var pastXDaysWorkout = persistence.workoutDataSince(date: Date.dateXDaysAgo(x: x))
        
        // We want to filter in order to remove today's workout from the list
        var new = [WorkoutData]()
        for i in pastXDaysWorkout {
            // If the day of this date is not the same as today
            if i.date?.day != Date().day {
                new.append(i)
            }
        }
        pastXDaysWorkout = new
        
        
        var absWorkouts : Array<WorkoutData> = []
        var armsWorkouts : Array<WorkoutData> = []
        var runWorkouts : Array<WorkoutData> = []
        var restCount : Int = 0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"

        // This part check for multiple workout of the same type on the same day to prevent counting them twice.
        for i in pastXDaysWorkout {
            if i.type == .abs {
                var canBeInserted = true
                for ab in absWorkouts {
                    if i.date?.day == ab.date?.day {
                        canBeInserted = false
                    }
                }
                if canBeInserted {
                    absWorkouts.append(i)
                }
            } else if i.type == .arms {
                var canBeInserted = true
                for arm in armsWorkouts {
                    if i.date?.day == arm.date?.day {
                        canBeInserted = false
                    }
                }
                if canBeInserted {
                    armsWorkouts.append(i)
                }
            } else if i.type == .run {
                var canBeInserted = true
                for arm in runWorkouts {
                    if i.date?.day == arm.date?.day {
                        canBeInserted = false
                    }
                }
                if canBeInserted {
                    runWorkouts.append(i)
                }
            }
        }
        
        var daysWhenWorkout : Array<Int> = []
        for i in pastXDaysWorkout {
            if !daysWhenWorkout.contains(i.date!.day) {
                daysWhenWorkout.append(i.date!.day)
            }
        }
        
        for i in 1...x - 1{
            print(Date.dateXDaysAgo(x: i).day)
            if !daysWhenWorkout.contains(Date.dateXDaysAgo(x: i).day) {
                restCount += 1
            }
        }
        return (armsWorkouts, absWorkouts, runWorkouts, restCount)
    }
    

    /// Return recommended workout.
    ///
    /// If the run workout is not specified it means that there was no run in the past x days.
    /// Returns the workout type and the text associated with it to display.
    func getTodayRecommendedWorkout() -> WorkoutType {

        let workouts = getSportArrayForLastXDays(x: 2)
        let armsWorkout = workouts.0.count
        let absWorkout = workouts.1.count
        let restWorkout = workouts.3
        if persistence.todayWorkout {
            return .alreadyWorkout
        }
        
        // Preventing no rest for 5 continuous day if the user didn't follow the programm that was given.
        if armsWorkout + absWorkout == armsGoal + absGoal {
            return .rest
        }
        
        if absWorkout < absGoal {
            if armsWorkout < armsGoal {
                if absWorkout <= armsWorkout {
                    return .abs
                } else {
                    return .arms
                }
            } else {
                return .abs
            }
        } else if armsWorkout < armsGoal {
            return .arms
        }
        
        return .rest
    }

    /// Return the recomendend workout associated with the text displayed to the user to explain.
    func getRecomendedAndText() -> (WorkoutType, String){
        let workout = getTodayRecommendedWorkout()
        return (workout, TrainingCalculator.textToDisplay[workout]!)
    }
    
    private func getDayComponent(date : Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        return components.day!
    }
}

