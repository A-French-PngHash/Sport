//
//  CurrentSportView.swift
//  sport
//
//  Created by Titouan Blossier on 14/02/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import SwiftUI

struct CurrentSportView: View {
    @Binding var displayLeadingArrow : Bool
    @Binding var displayTrailingArrow : Bool
    @Binding var currentSportName : String

    let leadingArrowTapped : () -> Void
    let trailingArrowTapped : () -> Void

    var body: some View {
        ZStack {
            // Using zstack to prevent the middle text from moving slightly to the left/right when one arrow is hidden.
            HStack {
                Spacer()
                Text(currentSportName)
                Spacer()
            }
            .font(.title)
            HStack {
                Button(action: {
                    leadingArrowTapped()
                }, label: {
                    Image(systemName: "arrow.uturn.backward")
                        .padding()
                })
                Spacer()
                Button(action: {
                    trailingArrowTapped()
                }, label: {
                    Image(systemName: "arrow.uturn.forward")
                        .padding()
                })
            }
            .font(.title2)
        }
    }
}

struct CurrentSportView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentSportView(displayLeadingArrow: .constant(true), displayTrailingArrow: .constant(true), currentSportName: .constant("Preview"), leadingArrowTapped: { }, trailingArrowTapped: { })
    }
}
