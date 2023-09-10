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
            DatePicker("Choose a date",
                       selection: $activity.end)
//                            Toggle("Important?", isOn: $item.isCritical)
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
