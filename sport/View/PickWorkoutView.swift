//
//  PickWorkoutView.swift
//  sport
//
//  Created by Titouan Blossier on 12/02/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import SwiftUI

struct PickWorkoutView: View {
    @EnvironmentObject var persistenceController : Persistence

    let workouts = Workouts.shared.allWorkouts

    @State private var calc_private : TrainingCalculator?
    var calculator : TrainingCalculator {
        if let calc = calc_private {
            return calc
        } else {
            calc_private = TrainingCalculator(persistence: persistenceController)
            return calc_private!
        }
    }
    /// Text to display which tells the user which type of workout is to be done today.
    @State var recomendedText : String = ""
    /// Recomended workout.
    @State var recomendedWorkout : WorkoutType = .rest

    /// Wether or not to display the alert after a tap on the register run button. This alert ask the user for confirmation.
    @State var shouldDisplayRegisterRunAlert : Bool = false


    var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Text("I Ran Today")
            })
            Image(systemName: "heart.fill")
                .foregroundColor(.green)
                .font(.system(size: 50))
                .padding()
            Text(recomendedText)
                .padding()
                .multilineTextAlignment(.center)

            List(0..<workouts.count, id: \.self) { index in
                HStack {
                    Button(action: {
                        //TODO: - Go to next view.
                    }, label: {
                        Text(workouts[index].name)
                            .foregroundColor(.primary)
                    })
                    if workouts[index].type == recomendedWorkout {
                        Image(systemName: "heart.circle.fill")
                            .foregroundColor(Color(UIColor(red:0/255.0, green:145/255.0, blue:147/255.0, alpha:1.0)))
                    }
                }
            }

        }
        .onAppear(perform: {
            let result = calculator.getRecomendedAndText()
            recomendedWorkout = result.0
            recomendedText = result.1
        })
        .navigationBarTitle("Workouts")
        .alert(isPresented: $shouldDisplayRegisterRunAlert, content: {

            Alert(
                title: Text("Register a run Session"),
                message: Text("Are you sure you want to register a run session. This action cannot be undone and will affect your recomendations."),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .default(Text("Yes"), action: {

                    persistenceController.insertWorkoutItem(date: Date(), workoutType: .run)
                    self.recomendedText = TrainingCalculator.textToDisplay[.alreadyWorkout]!
                })
            )

        })
    }
}

struct PickWorkoutView_Previews: PreviewProvider {
    static let persistenceController : Persistence = Persistence.preview
    static var previews: some View {
        PickWorkoutView()
            .environmentObject(persistenceController)
    }
}
