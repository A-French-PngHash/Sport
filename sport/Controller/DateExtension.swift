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
    func getMinutesAndSecondsFormatted(numberOfSeconds time : Double) -> (String, String) {
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
    
    var day : Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components.day!
    }
}
