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
    
    // SINGLETON
    static let shared = TrainingCalculator()
    private init() { }
    
    let persistentContainer = AppDelegate.app.persistentContainer
    let armsGoal = 2
    let absGoal = 2
    let restGoal = 1
    /*
     Return 2 array containing each one type of workout. There is a maximum of one workout per day per array.
     
     Also return one Int which is the number of rest day.
     
     WARNING : X must be less than 28 else it could cause problem.
     */
    private func getSportArrayForLastXDays(x : Int) -> (Array<WorkoutData>, Array<WorkoutData>, Int){
        let fiveDaysInSeconds = 3600 * 24 * x
        let pastXDaysWorkout = WorkoutData.workoutDataSince(date: Date().addingTimeInterval(TimeInterval(-fiveDaysInSeconds)))
        
        var absWorkouts : Array<WorkoutData> = []
        var armsWorkouts : Array<WorkoutData> = []
        var restCount : Int = 0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
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
            }
        }
        
        var daysWhenWorkout : Array<Int> = []
        for i in pastXDaysWorkout {
            if !daysWhenWorkout.contains(i.date!.day) {
                daysWhenWorkout.append(i.date!.day)
            }
        }
        
        for i in 1...x{
            print(dateXDaysAgo(x: i).day)
            if !daysWhenWorkout.contains(dateXDaysAgo(x: i).day) {
                restCount += 1
            }
        }
        return (armsWorkouts, absWorkouts, restCount)
    }
    
    func getTodayRecommendedWorkout() -> WorkoutType{
        let result = getSportArrayForLastXDays(x: 5)
        let armsWorkouts = result.0
        let absWorkouts = result.1
        let rest = result.2
        
        if absWorkouts.count != absGoal {
            if armsWorkouts.count != armsGoal {
                if absWorkouts.count <= armsWorkouts.count {
                    return .abs
                } else {
                    return .arms
                }
            } else {
                return .abs
            }
        } else if armsWorkouts.count != armsGoal {
            return .arms
        }
        return .rest
    }
    
    private func getDayComponent(date : Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        return components.day!
    }
    
    private func dateXDaysAgo(x : Int) -> Date{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let currentDate = calendar.date(from: components)!
        
        let dateXDaysAgo = currentDate.addingTimeInterval(TimeInterval(-3600 * 24 * x))
        return dateXDaysAgo
    }
}

