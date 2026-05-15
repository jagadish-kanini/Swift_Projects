import UIKit

protocol FilterDelegate: AnyObject {
    func didSelectCategory(_ category: Category?)
}

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: FilterDelegate?
    let viewModel = FilterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc private func doneTapped() {
        delegate?.didSelectCategory(viewModel.selectedCategory)
        dismiss(animated: true)
    }
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOptions
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        cell.textLabel?.text = viewModel.title(at: indexPath.row)
        cell.imageView?.image = UIImage(systemName: viewModel.icon(at: indexPath.row))
        cell.imageView?.tintColor = viewModel.color(at: indexPath.row)
        cell.accessoryType = viewModel.isSelected(at: indexPath.row) ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCategory(at: indexPath.row)
        tableView.reloadData()
    }
}
