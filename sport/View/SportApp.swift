//
//  SportApp.swift
//  sport
//
//  Created by Titouan Blossier on 12/02/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import SwiftUI
import CoreData

@main
struct SportApp: App {
    let persistenceController = Persistence()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                PickWorkoutView()
                    .environmentObject(persistenceController)
            }
        }
    }
}
