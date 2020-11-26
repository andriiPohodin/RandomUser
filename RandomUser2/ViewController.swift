
import UIKit

class ViewController: UIViewController {

    let service = UserService()
    var users = [Result]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        let nib = UINib(nibName: "MyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MyTableViewCell")
        service.getUsers { [weak self] (users) in
            self?.users = users
            self?.tableView.reloadData()
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        let result = users[indexPath.row]
        cell.titleLabel.text = result.name.title
        cell.fullNameLabel.text = result.name.fullName
        cell.cellNumberLabel.text = result.phone
        cell.emailLabel.text = result.email
        let url = URL(string: "\(result.picture.medium)")
        cell.profileImage.kf.indicatorType = .activity
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.height/2
        cell.profileImage.kf.setImage(with: url)
//        cell.profileImage.image = UIImage(named: "\(result.picture.medium)")
        return cell
    }
    
    
}
