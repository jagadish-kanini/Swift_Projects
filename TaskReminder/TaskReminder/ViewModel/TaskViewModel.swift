//
//  TaskViewModel.swift
//  TaskReminder
//
//  Created by Jagadish Mangini on 08/04/26.
//

import Foundation
import UserNotifications

class TaskViewModel {

    private let storageKey = "saved_tasks"
    private(set) var tasks: [Task] = []

    init() {
        loadTasks()
    }

    // MARK: - CRUD

    func addTask(_ task: Task) {
        tasks.append(task)
        sortTasks()
        saveTasks()
        scheduleNotification(for: task)
    }

    func updateTask(_ updatedTask: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) else { return }
        cancelNotification(for: tasks[index])
        tasks[index] = updatedTask
        sortTasks()
        saveTasks()
        scheduleNotification(for: updatedTask)
    }

    func deleteTask(at index: Int) {
        cancelNotification(for: tasks[index])
        tasks.remove(at: index)
        saveTasks()
    }

    func toggleComplete(at index: Int) {
        tasks[index].isCompleted.toggle()
        saveTasks()
    }

    // MARK: - Sorting & Grouping

    private func sortTasks() {
        tasks.sort { $0.dateTime < $1.dateTime }
    }

    var categories: [String] {
        var seen = [String]()
        for task in tasks where !seen.contains(task.category) {
            seen.append(task.category)
        }
        return seen
    }

    func tasks(for category: String) -> [Task] {
        return tasks.filter { $0.category == category }
    }

    func taskIndex(for category: String, row: Int) -> Int {
        let task = tasks(for: category)[row]
        return tasks.firstIndex(where: { $0.id == task.id }) ?? row
    }

    // MARK: - Validation

    func isValid(title: String, category: String, dateTime: Date) -> Bool {
        return !title.trimmingCharacters(in: .whitespaces).isEmpty &&
               !category.trimmingCharacters(in: .whitespaces).isEmpty &&
               dateTime > Date()
    }

    // MARK: - Persistence

    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }

    private func loadTasks() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([Task].self, from: data) else { return }
        tasks = decoded
        sortTasks()
    }

    // MARK: - Notifications

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    private func scheduleNotification(for task: Task) {
        let content = UNMutableNotificationContent()
        content.title = task.title
        content.body = task.message
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: task.dateTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    private func cancelNotification(for task: Task) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
    }
}
