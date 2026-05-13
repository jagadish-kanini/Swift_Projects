import UIKit

class UserListViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User]=[
        User(name: "Jagadish", email: "jagadish@gmail.com", phone: "+91 98765 43210", age: 25),
        User(name: "Rahul",   email: "rahul@gmail.com",   phone: "+91 91234 56789", age: 28),
        User(name: "Kiran",   email: "kiran@gmail.com",   phone: "+91 99887 76655", age: 23)
    ]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        title = "Users"
        
        tableView.delegate = self
        tableView.dataSource = self
        }
}
extension UserListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        
        let user = users[indexPath.row]
        
        cell.lblName.text = user.name
        cell.lblEmail.text = user.email
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showUserDetail", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetail",
           let indexPath = sender as? IndexPath,
           let vc = segue.destination as? UserDetailViewController {
            vc.user = users[indexPath.row]
        }
    }
}
