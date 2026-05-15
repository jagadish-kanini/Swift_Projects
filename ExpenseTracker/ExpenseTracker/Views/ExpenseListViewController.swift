import UIKit

class ExpenseListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!

    private let viewModel = ExpenseListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 72
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
    }

    private func setupNavBar() {
        title = "Expenses"
        navigationController?.navigationBar.prefersLargeTitles = false
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let filterBtn = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.rightBarButtonItems = [addBtn, filterBtn]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(named: "AccentColor")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    private func reloadData() {
        totalLabel.text = viewModel.totalText
        filterLabel.text = viewModel.filterText
        tableView.reloadData()
    }

    @objc private func addTapped() {
        performSegue(withIdentifier: "showAddExpense", sender: nil)
    }

    @objc private func filterTapped() {
        performSegue(withIdentifier: "showFilter", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let vc = segue.destination as? ExpenseDetailViewController,
           let index = tableView.indexPathForSelectedRow?.row {
            let expense = viewModel.expense(at: index)
            vc.viewModel = ExpenseDetailViewModel(expense: expense)
        } else if segue.identifier == "showFilter",
                  let nav = segue.destination as? UINavigationController,
                  let vc = nav.topViewController as? FilterViewController {
            vc.viewModel.selectedCategory = viewModel.selectedCategory
            vc.delegate = self
        }
    }
}

// MARK: - UITableViewDataSource & Delegate
extension ExpenseListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfExpenses
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseCell
        cell.configure(with: viewModel.expense(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteExpense(at: indexPath.row)
            reloadData()
        }
    }
}

// MARK: - FilterDelegate
extension ExpenseListViewController: FilterDelegate {
    func didSelectCategory(_ category: Category?) {
        viewModel.selectedCategory = category
        reloadData()
    }
}
