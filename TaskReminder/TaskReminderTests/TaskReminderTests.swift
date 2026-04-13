//
//  TaskReminderTests.swift
//  TaskReminderTests
//
//  Created by Jagadish Mangini on 08/04/26.
//

import XCTest
@testable import TaskReminder

final class TaskReminderTests: XCTestCase {

    var viewModel: TaskViewModel!

    override func setUp() {
        super.setUp()
        viewModel = TaskViewModel()
        // Clear any saved tasks before each test
        UserDefaults.standard.removeObject(forKey: "saved_tasks")
        viewModel = TaskViewModel()
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "saved_tasks")
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Validation Tests

    func testValidationFailsWithEmptyTitle() {
        let result = viewModel.isValid(title: "", category: "Work", dateTime: Date().addingTimeInterval(3600))
        XCTAssertFalse(result, "Validation should fail with empty title")
    }

    func testValidationFailsWithEmptyCategory() {
        let result = viewModel.isValid(title: "Task", category: "", dateTime: Date().addingTimeInterval(3600))
        XCTAssertFalse(result, "Validation should fail with empty category")
    }

    func testValidationFailsWithPastDate() {
        let result = viewModel.isValid(title: "Task", category: "Work", dateTime: Date().addingTimeInterval(-3600))
        XCTAssertFalse(result, "Validation should fail with past date")
    }

    func testValidationPassesWithValidInput() {
        let result = viewModel.isValid(title: "Task", category: "Work", dateTime: Date().addingTimeInterval(3600))
        XCTAssertTrue(result, "Validation should pass with valid input")
    }

    // MARK: - Sorting Tests

    func testTasksSortedByDateTimeEarliestFirst() {
        let task1 = Task(title: "Task 1", message: "Msg 1", category: "Work", dateTime: Date().addingTimeInterval(7200))
        let task2 = Task(title: "Task 2", message: "Msg 2", category: "Home", dateTime: Date().addingTimeInterval(3600))
        viewModel.addTask(task1)
        viewModel.addTask(task2)
        XCTAssertEqual(viewModel.tasks.first?.title, "Task 2", "Earlier task should be first")
    }

    // MARK: - CRUD Tests

    func testAddTask() {
        let task = Task(title: "Test Task", message: "Message", category: "Work", dateTime: Date().addingTimeInterval(3600))
        viewModel.addTask(task)
        XCTAssertEqual(viewModel.tasks.count, 1, "Task count should be 1 after adding")
    }

    func testDeleteTask() {
        let task = Task(title: "Test Task", message: "Message", category: "Work", dateTime: Date().addingTimeInterval(3600))
        viewModel.addTask(task)
        viewModel.deleteTask(at: 0)
        XCTAssertEqual(viewModel.tasks.count, 0, "Task count should be 0 after deleting")
    }

    func testUpdateTask() {
        var task = Task(title: "Old Title", message: "Message", category: "Work", dateTime: Date().addingTimeInterval(3600))
        viewModel.addTask(task)
        task.title = "New Title"
        viewModel.updateTask(task)
        XCTAssertEqual(viewModel.tasks.first?.title, "New Title", "Task title should be updated")
    }

    // MARK: - Persistence Tests

    func testTasksPersistedAfterReload() {
        let task = Task(title: "Persistent Task", message: "Message", category: "Work", dateTime: Date().addingTimeInterval(3600))
        viewModel.addTask(task)
        let newViewModel = TaskViewModel()
        XCTAssertEqual(newViewModel.tasks.count, 1, "Tasks should persist after reload")
    }
}
