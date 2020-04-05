//
//  GlobalDetailVC.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GlobalDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var data: CovidCountryModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupUI()
    }

    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupUI() {
        guard let data = data else {return}

        print(data.country)
    }
}

extension GlobalDetailVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "GlobalDetailCell")
        cell.textLabel?.text = "Item"
        cell.detailTextLabel?.text = "\(indexPath.row)"
        return cell
    }
}
