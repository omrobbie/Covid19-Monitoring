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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var dataGlobal = [CovidCountryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        loadData()
    }

    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func loadData() {
        ApiService.shared.getDataGlobalPerCountry() { (data) in
            self.dataGlobal = data
            self.tableView.reloadData()
            self.activityIndicator.isHidden = true
        }
    }
}

extension GlobalVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataGlobal.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalCell", for: indexPath)
        let item = dataGlobal[indexPath.row]

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = item.country

        return cell
    }
}
