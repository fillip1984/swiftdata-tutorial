//
//  ActivityUpdateView.swift
//  swiftdata-tutorial
//
//  Created by Phillip Williams on 9/10/23.
//

import SwiftData
import SwiftUI

struct ActivityUpdateView: View {
    @Environment(\.dismiss) var dismiss

    @Bindable var activity: Activity

    var body: some View {
        List {
            TextField("Name", text: $activity.text)

            // May not be the "apple way" but it works. Will figure this out once more tutorials on SwiftData appear. Idea came from: https://www.donnywals.com/providing-a-default-value-for-a-swiftui-binding/
            DatePicker("Choose a date",
                       selection:
                       Binding(get: {
                           activity.end ?? .now
                       }, set: { newValue in activity.end = newValue }), displayedComponents: .date)

            Button("Update") {
                dismiss()
            }
        }
        .navigationTitle("Update Activity")
    }
}

// #Preview {
//    ActivityUpdateView()
// }
