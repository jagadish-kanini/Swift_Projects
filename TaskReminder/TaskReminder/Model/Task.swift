//
//  Task.swift
//  TaskReminder
//
//  Created by Jagadish Mangini on 08/04/26.
//

import Foundation

struct Task: Codable {
    var id: UUID
    var title: String
    var message: String
    var category: String
    var dateTime: Date
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, message: String, category: String, dateTime: Date, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.message = message
        self.category = category
        self.dateTime = dateTime
        self.isCompleted = isCompleted
    }
}
