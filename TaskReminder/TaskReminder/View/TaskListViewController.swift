//
//  TaskListViewController.swift
//  TaskReminder
//
//  Created by Jagadish Mangini on 08/04/26.
//

import UIKit

class TaskListViewController: UITableViewController {

    private let viewModel = TaskViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Tasks"
        viewModel.requestNotificationPermission()
        setupUI()
    }

    private func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.90, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 1.0, alpha: 1.0)
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = viewModel.categories[section]
        return viewModel.tasks(for: category).count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.categories[section]
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.70, alpha: 1.0)
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        header.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 1.0, alpha: 1.0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let category = viewModel.categories[indexPath.section]
        let task = viewModel.tasks(for: category)[indexPath.row]
        cell.textLabel?.text = task.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.detailTextLabel?.text = "🕐 \(formattedDate(task.dateTime))"
        cell.detailTextLabel?.textColor = .gray
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        if task.isCompleted {
            cell.textLabel?.textColor = .systemGreen
            cell.accessoryType = .checkmark
            cell.tintColor = .systemGreen
        } else {
            cell.textLabel?.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.90, alpha: 1.0)
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self = self else { return }
            let category = self.viewModel.categories[indexPath.section]
            let index = self.viewModel.taskIndex(for: category, row: indexPath.row)
            self.viewModel.deleteTask(at: index)
            if self.viewModel.tasks(for: category).isEmpty {
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    override func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let category = viewModel.categories[indexPath.section]
        let task = viewModel.tasks(for: category)[indexPath.row]
        let title = task.isCompleted ? "Undo" : "Done ✓"
        let completeAction = UIContextualAction(style: .normal, title: title) { [weak self] _, _, completed in
            guard let self = self else { return }
            let index = self.viewModel.taskIndex(for: category, row: indexPath.row)
            self.viewModel.toggleComplete(at: index)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completed(true)
        }
        completeAction.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [completeAction])
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) { }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = viewModel.taskIndex(for: viewModel.categories[indexPath.section], row: indexPath.row)
        performSegue(withIdentifier: "showEditTask", sender: index)
    }

    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let formVC = segue.destination as? TaskFormViewController else { return }
        formVC.viewModel = viewModel
        if segue.identifier == "showEditTask", let index = sender as? Int {
            formVC.taskToEdit = viewModel.tasks[index]
        }
    }

    // MARK: - Helper

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
