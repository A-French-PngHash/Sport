//
//  WorkoutData.swift
//  sport
//
//  Created by Titouan Blossier on 13/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
import CoreData

class WorkoutData : NSManagedObject {
    static var all : [WorkoutData] {
        let request: NSFetchRequest<WorkoutData> = WorkoutData.fetchRequest()
        guard let workoutData = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return workoutData
    }
    
    var type: WorkoutType? {
            get {
                if let rawType = self.rawWorkoutType {
                    return WorkoutType(rawValue: rawType)
                } else {
                    return nil
                }
            }
            set {
                self.rawWorkoutType = newValue?.rawValue
            }
    }
    
    static func workoutDataSince(date : Date) -> Array<WorkoutData> {
        let predicate = NSPredicate(format: "%K >= %@", #keyPath(WorkoutData.date) ,date as NSDate)
        let sort = NSSortDescriptor(key: #keyPath(WorkoutData.date), ascending: true)
        
        let request: NSFetchRequest<WorkoutData> = WorkoutData.fetchRequest()
        
        request.predicate = predicate
        request.sortDescriptors = [sort]
        
        guard let workoutData = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return workoutData
    }
}
