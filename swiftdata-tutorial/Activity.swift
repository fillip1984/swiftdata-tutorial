//
//  Activity.swift
//  swiftdata-tutorial
//
//  Created by Phillip Williams on 9/10/23.
//
import Foundation
import SwiftData

@Model
class Activity {
    // id and audit fields
//    @Attribute(.unique)
//    var id: String
    var createdAt: Date
//    var updatedAt: Date

    var text: String

    // optional attributes for tracking start/end of activity
    var start: Date?
    var end: Date?

    // attributes for outcome of activity
    var complete: Bool
    var completedAt: Date?
    var skip: Bool

    init(
        //        id: String = "new",
        createdAt: Date = .now,
//        updatedAt: Date = .now,
        start: Date? = nil,
        end: Date? = nil,
        text: String = "",
        complete: Bool = false,
        skip: Bool = false)
    {
//        self.id = id
        self.createdAt = createdAt
//        self.updatedAt = updatedAt
        self.start = start
        self.end = end
        self.text = text
        self.complete = complete
        self.skip = skip
    }
}
