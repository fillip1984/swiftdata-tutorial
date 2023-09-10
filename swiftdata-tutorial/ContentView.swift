//
//  ContentView.swift
//  swiftdata-tutorial
//
//  Created by Phillip Williams on 9/10/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context
    
    @State var showCreate = false
    @State var activityToEdit: Activity?
    
    // returns all
    // @Query var activities: [Activity]
    // returns all not completed
    @Query(
        filter: #Predicate<Activity> { $0.complete == false },
        sort: \.end,
        order: .reverse
    ) var activities: [Activity]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities) { activity in
                    HStack {
                        VStack(alignment: .leading) {
                            //                            if item.isCritical {
                            //                                Image(systemName: "exclamationmark.3")
                            //                                    .symbolVariant(.fill)
                            //                                    .foregroundColor(.red)
                            //                                    .font(.largeTitle)
                            //                                    .bold()
                            //                            }
                            
                            Text(activity.text)
                                .font(.largeTitle)
                                .bold()
                            // See: https://stackoverflow.com/questions/52393094/value-of-optional-type-date-not-unwrapped-did-you-mean-to-use-or-in
//                            if let end = activity.end {
//                                Text("\(end, format: Date.FormatStyle(date: .numeric, time: .shortened))")
//                                    .font(.callout)
//                            }
                            
                            Text("\(activity.end, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                .font(.callout)
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
            .navigationTitle("Activities")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showCreate.toggle()
                    }, label: {
                        Label("+", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $showCreate,
                   content: {
                       NavigationStack {
                           ActivityCreateView()
                       }
                       .presentationDetents([.medium])
                   })
            .sheet(item: $activityToEdit) {
                activityToEdit = nil
            } content: { activity in
                ActivityUpdateView(activity: activity)
            }
        }
    }
}

#Preview {
    ContentView()
}
