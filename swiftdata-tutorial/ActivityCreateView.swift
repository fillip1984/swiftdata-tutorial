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

    // Sets focus on sheet appearing,
    // See: https://www.kodeco.com/31569019-focus-management-in-swiftui-getting-started?page=2
    // Or: https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-textfield-or-texteditor-have-default-focus
    // Or: https://developer.apple.com/forums/thread/681962
    enum FocusField: Hashable {
        case text, end
    }

    @FocusState private var focusedField: FocusField?

    @State private var activity = Activity()

    var body: some View {
        Form {
            TextField("Name", text: $activity.text)
                .focused($focusedField, equals: .text)

            // May not be the "apple way" but it works. Will figure this out once more tutorials on SwiftData appear. Idea came from: https://www.donnywals.com/providing-a-default-value-for-a-swiftui-binding/
            DatePicker("Choose a date",
                       selection:
                       Binding(get: {
                           activity.end ?? .now
                       }, set: { newValue in activity.end = newValue }), displayedComponents: <#T##DatePickerComponents#>.date)

            Button("Create") {
                withAnimation {
                    context.insert(activity)
                }
                dismiss()
            }
        }
        .navigationTitle("Create Activity")
        .onAppear {
            focusedField = .text
        }
    }
}

#Preview {
    ActivityCreateView()
}
