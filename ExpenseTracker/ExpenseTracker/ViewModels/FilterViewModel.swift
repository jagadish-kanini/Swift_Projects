import UIKit

class FilterViewModel {

    var selectedCategory: Category?
    let options: [Category?] = [nil] + Category.allCases

    var numberOfOptions: Int { options.count }

    func category(at index: Int) -> Category? {
        options[index]
    }

    func title(at index: Int) -> String {
        options[index]?.rawValue ?? "All Categories"
    }

    func icon(at index: Int) -> String {
        guard let category = options[index] else { return "square.grid.2x2" }
        switch category {
        case .food: return "fork.knife.circle.fill"
        case .travel: return "airplane.circle.fill"
        case .shopping: return "bag.circle.fill"
        case .bills: return "doc.circle.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }

    func color(at index: Int) -> UIColor {
        guard let category = options[index] else { return .systemPurple }
        switch category {
        case .food: return .systemOrange
        case .travel: return .systemBlue
        case .shopping: return .systemGreen
        case .bills: return .systemPurple
        case .other: return .systemGray
        }
    }

    func isSelected(at index: Int) -> Bool {
        options[index] == selectedCategory
    }

    func selectCategory(at index: Int) {
        selectedCategory = options[index]
    }
}
