import UIKit

class ExpenseDetailViewModel {

    private let store = ExpenseStore.shared
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMM d, yyyy (EEEE)"
        return f
    }()

    var expense: Expense

    init(expense: Expense) {
        self.expense = expense
    }

    var icon: String { expense.category.icon }
    var title: String { expense.title }
    var categoryText: String { expense.category.rawValue }
    var amountText: String { String(format: "$%.2f", expense.amount) }
    var dateText: String { dateFormatter.string(from: expense.date) }
    var notesText: String { expense.notes.isEmpty ? "—" : expense.notes }
    var categoryDetailText: String { "● \(expense.category.rawValue)" }

    var categoryColor: UIColor {
        switch expense.category {
        case .food: return .systemOrange
        case .travel: return .systemBlue
        case .shopping: return .systemGreen
        case .bills: return .systemPurple
        case .other: return .systemGray
        }
    }

    var iconBackgroundColor: UIColor {
        categoryColor.withAlphaComponent(0.2)
    }

    func deleteExpense() {
        store.delete(id: expense.id)
    }
}
