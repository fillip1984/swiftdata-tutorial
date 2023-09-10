//
//  ActivityCreateView.swift
//  swiftdata-tutorial
//
//  Created by Phillip Williams on 9/10/23.
//

import SwiftUI

struct ActivityCreateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State private var activity = Activity()

    var body: some View {
        List {
            TextField("Name", text: $activity.text)
            DatePicker("Choose a date",
                       selection: $activity.end, displayedComponents: .date)
//            Toggle("Important?", isOn: $item.isCritical)
            Button("Create") {
                withAnimation {
                    context.insert(activity)
                }
                dismiss()
            }
        }
        .navigationTitle("Create Activity")
    }
}

#Preview {
    ActivityCreateView()
}
