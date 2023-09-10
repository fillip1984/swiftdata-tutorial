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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    Activity.self
                ])
        }
    }
}
