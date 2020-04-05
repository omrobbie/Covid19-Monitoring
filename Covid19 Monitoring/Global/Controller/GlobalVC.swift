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
    var dataSave = [CovidCountryModel]()

    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        loadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GlobalDetailVC" {
            if let vc = segue.destination as? GlobalDetailVC {
                if let data = sender as? CovidCountryModel {
                    vc.data = data
                }
            }
        }
    }

    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    private func loadData() {
        ApiService.shared.getDataGlobalPerCountry() { (data) in
            self.dataGlobal = data
            self.dataSave = data
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalCell", for: indexPath) as! GlobalCell
        let item = dataGlobal[indexPath.row]

        cell.accessoryType = .disclosureIndicator
        cell.parseData(data: item)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GlobalDetailVC", sender: dataGlobal[indexPath.row])
    }
}

extension GlobalVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataGlobal = dataSave
        timer.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            if !searchText.isEmpty {
                self.dataGlobal.removeAll { !$0.country.lowercased().contains(searchText.lowercased()) }
            }

            self.tableView.reloadData()
        })
    }
}
