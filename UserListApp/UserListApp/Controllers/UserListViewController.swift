import UIKit

class UserListViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User]=[
        User(name: "Jagadish",
             email: "jagadish@gmail.com"),
        User(name: "Rahul",
             email: "rahul@gmail.com"),
        User(name: "Kiran",
             email: "kiran@gmail.com")
    ]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
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
}
