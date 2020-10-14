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
        return Persistence.shared.fetchAll()
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
}
