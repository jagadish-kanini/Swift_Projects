import Foundation

class ExpenseStore {
    static let shared = ExpenseStore()
    private let key = "saved_expenses"

    private(set) var expenses: [Expense] = []

    private init() { load() }

    func add(_ expense: Expense) {
        expenses.insert(expense, at: 0)
        save()
    }

    func delete(at index: Int) {
        expenses.remove(at: index)
        save()
    }

    func delete(id: UUID) {
        expenses.removeAll { $0.id == id }
        save()
    }

    func expenses(for category: Category?) -> [Expense] {
        guard let category else { return expenses }
        return expenses.filter { $0.category == category }
    }

    var total: Double { expenses.reduce(0) { $0 + $1.amount } }

    private func save() {
        if let data = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let saved = try? JSONDecoder().decode([Expense].self, from: data) else { return }
        expenses = saved
    }
}
