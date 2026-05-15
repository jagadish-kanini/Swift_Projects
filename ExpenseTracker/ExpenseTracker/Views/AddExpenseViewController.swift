import UIKit

class AddExpenseViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!

    private let viewModel = AddExpenseViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Expense"
        setupNavBar()
        setupCategoryMenu()
        setupUI()
    }

    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.systemPurple
        navigationItem.leftBarButtonItem?.tintColor = UIColor.systemPurple
    }

    private func setupUI() {
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        notesTextView.layer.borderColor = UIColor.systemGray4.cgColor
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.cornerRadius = 8
    }

    private func setupCategoryMenu() {
        let actions = Category.allCases.map { category in
            UIAction(title: category.rawValue) { [weak self] _ in
                self?.viewModel.selectedCategory = category
                self?.categoryButton.setTitle(category.rawValue, for: .normal)
                self?.categoryButton.setTitleColor(.label, for: .normal)
            }
        }
        categoryButton.menu = UIMenu(children: actions)
        categoryButton.showsMenuAsPrimaryAction = true
    }

    @objc private func cancelTapped() {
        dismiss(animated: true)
    }

    @objc private func saveTapped() {
        if let error = viewModel.validate(title: titleTextField.text, amount: amountTextField.text) {
            showAlert(error)
            return
        }
        viewModel.saveExpense(
            title: titleTextField.text ?? "",
            amount: amountTextField.text ?? "",
            date: datePicker.date,
            notes: notesTextView.text ?? ""
        )
        dismiss(animated: true)
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Validation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
