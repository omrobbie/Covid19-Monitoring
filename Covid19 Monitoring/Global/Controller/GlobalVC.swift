//
//  GlobalVC.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GlobalVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
    }

    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension GlobalVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Item \(indexPath.row)"
        return cell
    }
}
