//
//  SettingsTableViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    // создаем массив марсоходов
    let rovers = ["Spirit", "Opportunity", "Curiosity", "Perseverance"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rovers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // регистрируем ячейку
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // получаем марсоход конкретной строки
        let rover = rovers[indexPath.row]
        // устанавливаем марсоход в надпись ячейки
        cell.textLabel?.text = rover
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Нажата строка \(indexPath.row)")
    }

}
