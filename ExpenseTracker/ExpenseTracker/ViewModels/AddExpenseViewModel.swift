import Foundation

class AddExpenseViewModel {

    private let store = ExpenseStore.shared

    var selectedCategory: Category?

    func validate(title: String?, amount: String?) -> String? {
        guard let title = title, !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return "Please enter a title."
        }
        guard let amount = amount, let value = Double(amount), value > 0 else {
            return "Please enter a valid amount."
        }
        guard selectedCategory != nil else {
            return "Please select a category."
        }
        return nil
    }

    func saveExpense(title: String, amount: String, date: Date, notes: String) {
        guard let value = Double(amount), let category = selectedCategory else { return }
        let expense = Expense(
            title: title.trimmingCharacters(in: .whitespaces),
            amount: value,
            category: category,
            date: date,
            notes: notes
        )
        store.add(expense)
    }
}
