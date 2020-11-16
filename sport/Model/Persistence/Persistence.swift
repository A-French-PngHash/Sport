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
    
    // Mainly for testing.
    init(container : NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    // Using the default initializer for production version.
    convenience init() {
        self.init(container: AppDelegate.persistentContainer)
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
