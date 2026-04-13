//
//  TaskFormViewController.swift
//  TaskReminder
//
//  Created by Jagadish Mangini on 08/04/26.
//

import UIKit

class TaskFormViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!

    var viewModel: TaskViewModel!
    var taskToEdit: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let task = taskToEdit {
            titleTextField.text = task.title
            categoryTextField.text = task.category
            messageTextView.text = task.message
            datePicker.date = task.dateTime
        }
    }

    private func setupUI() {
        title = taskToEdit == nil ? "Add Task" : "Edit Task"
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 1.0, alpha: 1.0)

        // Navigation bar styling
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.90, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white

        // Title field
        styleTextField(titleTextField, placeholder: "Task Title", icon: "📝")

        // Category field
        styleTextField(categoryTextField, placeholder: "Category (e.g. Work, Home)", icon: "🏷️")

        // Message text view
        messageTextView.layer.cornerRadius = 12
        messageTextView.layer.borderWidth = 1.5
        messageTextView.layer.borderColor = UIColor(red: 0.33, green: 0.33, blue: 0.90, alpha: 0.4).cgColor
        messageTextView.font = UIFont.systemFont(ofSize: 16)
        messageTextView.textColor = .darkGray
        messageTextView.backgroundColor = .white
        messageTextView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)

        // Date picker
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = UIColor(red: 0.33, green: 0.33, blue: 0.90, alpha: 1.0)
        datePicker.minimumDate = Date()
        datePicker.backgroundColor = .white
        datePicker.layer.cornerRadius = 12
        datePicker.layer.borderWidth = 1.5
        datePicker.layer.borderColor = UIColor(red: 0.33, green: 0.33, blue: 0.90, alpha: 0.4).cgColor
        datePicker.clipsToBounds = true
        datePicker.contentHorizontalAlignment = .center
    }

    private func styleTextField(_ textField: UITextField, placeholder: String, icon: String) {
        textField.placeholder = "\(icon)  \(placeholder)"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor(red: 0.33, green: 0.33, blue: 0.90, alpha: 0.4).cgColor
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        guard let title = titleTextField.text,
              let category = categoryTextField.text,
              viewModel.isValid(title: title, category: category, dateTime: datePicker.date) else {
            showAlert(message: "Please enter a valid title, category and a future date.")
            return
        }

        let message = messageTextView.text ?? ""

        if var task = taskToEdit {
            task.title = title
            task.message = message
            task.category = category
            task.dateTime = datePicker.date
            viewModel.updateTask(task)
        } else {
            let task = Task(title: title, message: message, category: category, dateTime: datePicker.date)
            viewModel.addTask(task)
        }

        navigationController?.popViewController(animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
