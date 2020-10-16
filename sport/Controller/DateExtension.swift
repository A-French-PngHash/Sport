//
//  DateExtension.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

extension Date {
    //Returns two string, the number of minutes and the number of seconds calculated from the number of seconds given as argument
    static public func getMinutesAndSecondsFormatted(numberOfSeconds time : Double) -> (String, String) {
        var minutes = String(Int((floor((time.truncatingRemainder(dividingBy: 3600)) / 60))))
        var seconds = String(Int(floor(time - Double(minutes)! * 60)))
        if minutes.count == 1 {
            minutes = "0\(minutes)"
        }
        if seconds.count == 1 {
            seconds = "0\(seconds)"
        }
        return(minutes, seconds)
    }
    
    public var day : Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components.day!
    }
    
    
    static public func dateXDaysAgo(x : Int) -> Date{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let currentDate = calendar.date(from: components)!
        
        let dateXDaysAgo = currentDate.addingTimeInterval(TimeInterval(-3600 * 24 * x))
        return dateXDaysAgo
    }
    
    /// The date at midnight of the actual date object.
    public var dateAtMidnight : Date {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: self)
            let currentDate = calendar.date(from: components)!
            
            return currentDate
        }
    }
}
