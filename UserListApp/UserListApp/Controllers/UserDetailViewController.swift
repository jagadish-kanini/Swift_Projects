//
//  UserDetailViewController.swift
//  UserListApp
//
//  Created by Jagadish Mangini on 12/05/26.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAge: UILabel!

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemBlue
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        lblName.text  = user?.name
        lblEmail.text = user?.email
        lblPhone.text = user?.phone
        if let age = user?.age {
            lblAge.text = "Age: \(age)"
        }
    }
}
