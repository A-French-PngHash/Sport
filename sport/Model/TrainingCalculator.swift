//
//  TrainingCalculator.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation

class TrainingCalculator {
    // SINGLETON
    let shared = TrainingCalculator()
    private init() { }
    
    let persistentContainer = AppDelegate.app.persistentContainer
    
    // Calculated properties
    func getWorkoutsSince(date : Date) {
        
    }
}

