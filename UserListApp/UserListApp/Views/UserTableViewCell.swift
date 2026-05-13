import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!

    @IBOutlet weak var lblEmail: UILabel!

    @IBOutlet weak var profileImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        profileImage.layer.cornerRadius = 30

        profileImage.clipsToBounds = true
    }
}
