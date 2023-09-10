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
        .onAppear {
            focusedField = .text
        }
    }
}

#Preview {
    ActivityCreateView()
}
