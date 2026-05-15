import Foundation

enum Category: String, CaseIterable, Codable {
    case food = "Food"
    case travel = "Travel"
    case shopping = "Shopping"
    case bills = "Bills"
    case other = "Other"

    var icon: String {
        switch self {
        case .food: return "🍽️"
        case .travel: return "✈️"
        case .shopping: return "🛍️"
        case .bills: return "📄"
        case .other: return "⚪"
        }
    }

    var color: String {
        switch self {
        case .food: return "orange"
        case .travel: return "blue"
        case .shopping: return "green"
        case .bills: return "purple"
        case .other: return "gray"
        }
    }
}

struct Expense: Codable {
    var id: UUID
    var title: String
    var amount: Double
    var category: Category
    var date: Date
    var notes: String

    init(title: String, amount: Double, category: Category, date: Date, notes: String = "") {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.category = category
        self.date = date
        self.notes = notes
    }
}
