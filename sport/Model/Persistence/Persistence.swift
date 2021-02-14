//
//  Persistence.swift
//  sport
//
//  Created by Titouan Blossier on 13/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
import CoreData

class Persistence : ObservableObject{
    
    let persistentContainer : NSPersistentContainer!
    
    /// A context variable taken from the persistentContainer.
    lazy var context : NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    /// Describe if there was already a workout today
    var todayWorkout : Bool {
        get {
            return !workoutDataSince(date: Date().dateAtMidnight).isEmpty
        }
    }

    // A test configuration for SwiftUI previews
    static var preview: Persistence = {
        let persistence = Persistence(inMemory: true)

        let workout = WorkoutData(context: persistence.context)
        workout.rawWorkoutType = "abs"
        workout.date = Date()

        return persistence
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store. The optional container parameter is for testing to provide a container with existing data.
    init(inMemory: Bool = false, container : NSPersistentContainer? = nil) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        if let container = container {
            persistentContainer = container
        } else {
            persistentContainer = NSPersistentContainer(name: "Sport")
        }

        if inMemory {
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    ///Create and save a workout item into the database.
    /// - parameter date : The date when the workout took place.
    func insertWorkoutItem(date : Date, workoutType : WorkoutType) {
        let workoutData = WorkoutData(context: context)
        workoutData.type = workoutType
        workoutData.date = date
        save()
    }
    
    /**
     Fetch all the workout data from the Core Data database.

     - returns :
     An array of WorkoutData.
     **/
    func fetchAll() -> Array<WorkoutData>{
        let request: NSFetchRequest<WorkoutData> = WorkoutData.fetchRequest()
        guard let workoutData = try? context.fetch(request) else { return [] }
        return workoutData
    }
    
    func workoutDataSince(date : Date) -> Array<WorkoutData> {
        let predicate = NSPredicate(format: "%K >= %@", #keyPath(WorkoutData.date) ,date as NSDate)
        let sort = NSSortDescriptor(key: #keyPath(WorkoutData.date), ascending: true)
        
        let request: NSFetchRequest<WorkoutData> = WorkoutData.fetchRequest()
        
        request.predicate = predicate
        request.sortDescriptors = [sort]
        
        guard let workoutData = try? context.fetch(request) else { return [] }
        return workoutData
    }
    
    /// Remove the item corresponding to the id from the Core Data database.
    /// - parameter id : The item id.
    func remove(id : NSManagedObjectID) {
        let obj = context.object(with: id)
        context.delete(obj)
        save()
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("There was an error while saving the context.")
            }
        }
    }
}
