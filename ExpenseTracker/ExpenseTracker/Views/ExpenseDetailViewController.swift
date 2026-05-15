import UIKit

class ExpenseDetailViewController: UIViewController {

    var viewModel: ExpenseDetailViewModel!

    @IBOutlet weak var iconContainer: UIView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailTitleValue: UILabel!
    @IBOutlet weak var detailAmountValue: UILabel!
    @IBOutlet weak var detailCategoryValue: UILabel!
    @IBOutlet weak var detailDateValue: UILabel!
    @IBOutlet weak var detailNotesValue: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expense Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        setupUI()
        populate()
    }

    private func setupUI() {
        iconContainer.layer.cornerRadius = 35
        deleteButton.layer.cornerRadius = 12
        deleteButton.backgroundColor = .systemRed
    }

    private func populate() {
        iconLabel.text = viewModel.icon
        iconContainer.backgroundColor = viewModel.iconBackgroundColor
        expenseTitleLabel.text = viewModel.title
        categoryLabel.text = viewModel.categoryText
        categoryLabel.textColor = viewModel.categoryColor
        amountLabel.text = viewModel.amountText
        dateLabel.text = viewModel.dateText
        detailTitleValue.text = viewModel.title
        detailAmountValue.text = viewModel.amountText
        detailCategoryValue.text = viewModel.categoryDetailText
        detailDateValue.text = viewModel.dateText
        detailNotesValue.text = viewModel.notesText
    }

    @objc private func editTapped() {
        // Future: implement edit
    }

    @IBAction func deleteTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete Expense", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteExpense()
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}
