import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var iconContainer: UIView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMM d, yyyy"
        return f
    }()

    func configure(with expense: Expense) {
        titleLabel.text = expense.title
        categoryLabel.text = expense.category.rawValue
        amountLabel.text = String(format: "$%.2f", expense.amount)
        dateLabel.text = dateFormatter.string(from: expense.date)
        iconLabel.text = expense.category.icon
        iconContainer.backgroundColor = categoryColor(expense.category).withAlphaComponent(0.15)
        iconContainer.layer.cornerRadius = 22
    }

    private func categoryColor(_ category: Category) -> UIColor {
        switch category {
        case .food: return .systemOrange
        case .travel: return .systemBlue
        case .shopping: return .systemGreen
        case .bills: return .systemPurple
        case .other: return .systemGray
        }
    }
}
