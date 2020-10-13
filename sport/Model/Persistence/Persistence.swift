//
//  Persistence.swift
//  sport
//
//  Created by Titouan Blossier on 13/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
import CoreData

class Persistence {
    static let shared = Persistence()
    private init() { }
    
    let persistentContainer = AppDelegate.app.persistentContainer
    lazy var content : NSManagedObject {
        return self.persistentContainer.viewContext
    }
    
    func saveWorkout(date : Date, workoutType : WorkoutType) {
        let workoutData = WorkoutData(context: persistentContainer.viewContext)
        workoutData.type = workoutType
        workoutData.date = date
        do {
            try persistentContainer.viewContext.save()
        } catch {
            fatalError("There was an error while saving the context.")
        }
    }
}
