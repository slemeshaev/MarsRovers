//
//  SettingsTableViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // создаем кнопку галочки
    private let checkmark: UIImageView = {
        let image = UIImage(systemName: "checkmark.circle")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 70))
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.numberOfLines = 0
        let attributedText = NSMutableAttributedString(string: "ВЫБИРАЕМ\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(NSAttributedString(string: "Марсоходы", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]))
        label.attributedText = attributedText

        headerView.addSubview(label)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return API.rovers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // регистрируем ячейку
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // получаем марсоход конкретной строки
        let rover = API.rovers[indexPath.row]
        // устанавливаем марсоход в надпись ячейки
        cell.textLabel?.text = rover
        self.navigationItem.title = "Настройки"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rover = API.rovers[indexPath.row]
        print("Название марсохода: \(rover)")
        let camerasVC = CamerasViewController()
        camerasVC.nameLabel.text = rover
        //navigationController?.pushViewController(camerasVC, animated: true)
        //view.addSubview(checkmark)
    }

}
