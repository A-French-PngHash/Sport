//
//  WorkoutView.swift
//  sport
//
//  Created by Titouan Blossier on 14/02/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import SwiftUI

struct WorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var persistenceController : Persistence

    var workout : WorkoutProtocol
    /// Wether or not to display the alert asking for confirmation on the user cancelling the current workout.
    let session : SportSession
    @State var displayWorkoutCancelAlert : Bool = false

    init(workout : WorkoutProtocol) {
        self.workout = workout
        self.session = SportSession(workout: workout, persistence: persistenceController)
    }

    var body: some View {
        VStack {
            CurrentSportView(
                displayLeadingArrow: session.bindingCanGoNextSport,
                displayTrailingArrow: session.bindingCanGoPreviousSport,
                currentSportName: <#T##Binding<String>#>, leadingArrowTapped: <#T##() -> Void#>, trailingArrowTapped: <#T##() -> Void#>)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(workout.name)
        .navigationBarItems(
            leading: Button(action: {
                displayWorkoutCancelAlert = true
            }, label: {
                Text("Cancel")
            }))
        .alert(isPresented: $displayWorkoutCancelAlert, content: {
            Alert(
                title: Text("Quit workout"),
                message: Text("Are you sure you want to quit this workout ? It might not be saved in the database."),
                primaryButton: .destructive(Text("Yes"), action: {
                    presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .cancel())
        })
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutView(workout: AbsSecondWorkout())
        }
    }
}
