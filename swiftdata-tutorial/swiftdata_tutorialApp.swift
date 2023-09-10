//
//  swiftdata_tutorialApp.swift
//  swiftdata-tutorial
//
//  Created by Phillip Williams on 9/10/23.
//

import SwiftData
import SwiftUI

@main
struct swiftdata_tutorialApp: App {
    @State var showCreate = false
    @State var hideComplete = true

    var body: some Scene {
        WindowGroup {
            TabView {
                activityList
                admin
            }
            .modelContainer(for: [
                Activity.self
            ])
        }
    }

    var activityList: some View {
        NavigationStack {
            ActivityList(_activities: activityQuery)
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showCreate.toggle()
                        }, label: {
                            Label("+", systemImage: "plus")
                        })
                    }
                    ToolbarItem {
                        Button(action: {
                            hideComplete.toggle()
                        }, label: {
                            Image(systemName: "checkmark")
                                .symbolVariant(.circle.fill)
                                .foregroundStyle(hideComplete ? .gray : .green)
                        })
                    }
                }
        }
        .navigationTitle("Activities")
        .tabItem { Label("Activities", systemImage: "note") }
        .sheet(isPresented: $showCreate,
               content: {
                   NavigationStack {
                       ActivityCreateView()
                   }
                   .presentationDetents([.medium])
               })
    }

    // returns all
    //    @Query var activities: [Activity]
    // OR: returns all not completed
    //    @Query(
    //        filter: #Predicate<Activity> { $0.complete == false },
    //        sort: \.end,
    //        order: .reverse
    //    ) var activities: [Activity]
    // OR: dynamic query, See: https://github.com/alfianlosari/NoteAppSwiftData/blob/main/Shared/NoteSwiftDataApp.swift
    var activityQuery: Query<Activity, [Activity]> {
        let sortOrder: SortOrder = .reverse
        var predicate: Predicate<Activity>?
        if hideComplete {
            predicate = .init(#Predicate { $0.complete == false })
        }

        return Query(filter: predicate, sort: \.end, order: sortOrder)
    }

    var admin: some View {
        NavigationStack {
            Text("Admin stuff")
        }
        .navigationTitle("Activities")
        .tabItem { Label("Admin", systemImage: "gear") }
    }
}
