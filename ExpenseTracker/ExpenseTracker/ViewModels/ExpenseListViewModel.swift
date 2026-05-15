import Foundation

class ExpenseListViewModel {

    private let store = ExpenseStore.shared

    var selectedCategory: Category? = nil

    var expenses: [Expense] {
        store.expenses(for: selectedCategory)
    }

    var totalText: String {
        let total = selectedCategory == nil ? store.total : expenses.reduce(0) { $0 + $1.amount }
        return String(format: "$%.2f", total)
    }

    var filterText: String {
        selectedCategory == nil ? "All Expenses" : "\(selectedCategory!.rawValue) Expenses"
    }

    var numberOfExpenses: Int {
        expenses.count
    }

    func expense(at index: Int) -> Expense {
        expenses[index]
    }

    func deleteExpense(at index: Int) {
        let expense = expenses[index]
        store.delete(id: expense.id)
    }
}
