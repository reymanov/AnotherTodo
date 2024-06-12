//
//  Item.swift
//  AnotherTodo
//
//  Created by Kuba Rejmann on 11/06/2024.
//

import SwiftUI
import SwiftData

@Model
final class Todo {
    private(set) var id: String = UUID().uuidString
    var task: String
    var isCompleted: Bool = false
    var priority: Priority = Priority.low
    var createdAt: Date = Date.now
    var updatedAt: Date = Date.now
    
    init(task: String, priority: Priority) {
        self.task = task
        self.priority = priority
    }
}

enum Priority: String, Codable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var color: Color {
        switch self {
        case .low:
            return .green
        case .medium:
            return .yellow
        case .high:
            return .red
        }
    }
}
