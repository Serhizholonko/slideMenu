//
//  MenuController.swift
//  slideOutMenu
//
//  Created by apple on 07.10.2022.
//

import UIKit

class MenuController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        view.backgroundColor = .blue
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "Menu"
        return cell
    }
}
