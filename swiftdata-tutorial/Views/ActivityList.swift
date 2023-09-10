//
//  ActivityList.swift
//  swiftdata-tutorial
//
//  Created by Phillip Williams on 9/10/23.
//

import SwiftData
import SwiftUI

struct ActivityList: View {
    @Environment(\.modelContext) var context
    @Query var activities: [Activity]
    
    @State var showCreate = false
    @State var activityToEdit: Activity?
    
    var body: some View {
        List {
            ForEach(activities) { activity in
                HStack {
                    VStack(alignment: .leading) {
                        Text(activity.text)
                            .font(.largeTitle)
                            .bold()
                        // See: https://stackoverflow.com/questions/52393094/value-of-optional-type-date-not-unwrapped-did-you-mean-to-use-or-in
                        if let end = activity.end {
                            Text("\(end, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                .font(.callout)
                        }
                    }
                        
                    Spacer()
                        
                    Button {
                        withAnimation {
                            activity.complete.toggle()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .symbolVariant(.circle.fill)
                            .foregroundStyle(activity.complete ? .green : .gray)
                            .font(.largeTitle)
                    }
                    .buttonStyle(.plain)
                }
                .swipeActions(allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        withAnimation {
                            context.delete(activity)
                        }
                            
                    } label: {
                        Label("Delete", systemImage: "trash")
                            .symbolVariant(.fill)
                    }
                        
                    Button {
                        activityToEdit = activity
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.orange)
                }
            }
        }
        .sheet(item: $activityToEdit) {
            activityToEdit = nil
        } content: { activity in
            ActivityUpdateView(activity: activity)
        }
    }
}

#Preview {
    ActivityList()
}
