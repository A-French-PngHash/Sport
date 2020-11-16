//
//  fakeCoreDataUtils.swift
//  sportTests
//
//  Created by Titouan Blossier on 13/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
import CoreData
@testable import sport

class FakeCoreData {
    static let shared = FakeCoreData()
    private init() { }
    

    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportFake", managedObjectModel: self.managedObjectModel)
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            description.shouldAddStoreAsynchronously = false // Make it simpler in test env
            
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { (description, error) in
                // Check if the data store is in memory
                precondition( description.type == NSInMemoryStoreType )
                                            
                // Check if creating container wrong
                if let error = error {
                    fatalError("Create an in-mem coordinator failed \(error)")
                }
            }
            return container
        }()
    
    /*
     In test target, the container can not automatically find the managed object model since the namespaces are different. So we have to assign the managed object model ourselves.
     */
    lazy var managedObjectModel: NSManagedObjectModel = {
            let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
            return managedObjectModel
        }()
    
    //MARK: - Functions :
    func insertWorkoutItem(date : Date, type : WorkoutType) {
        let item = WorkoutData(context: mockPersistantContainer.viewContext)
        item.date = date
        item.type = type
        
        try! mockPersistantContainer.viewContext.save()
    }
    
    func flushData() {
        let request: NSFetchRequest<WorkoutData> = WorkoutData.fetchRequest()
        let objs = try! mockPersistantContainer.viewContext.fetch(request)
        
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        try! mockPersistantContainer.viewContext.save()
    }
}
