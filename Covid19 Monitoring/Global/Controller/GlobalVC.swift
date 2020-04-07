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

    private var dataGlobal = [CovidCountryModel]()
    private var dataSave = [CovidCountryModel]()

    private var timer = Timer()

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

    @IBAction func btnSort(_ sender: Any) {
        let alertVC = UIAlertController(title: "Urutkan berdasarkan", message: nil, preferredStyle: .actionSheet)

        let actionCancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)


        let actionCases = UIAlertAction(title: "Kasus terbanyak", style: .default) { (_) in
            self.dataGlobal.sort(by: { $0.cases > $1.cases } )
            self.tableView.reloadData()
        }

        let actionDeaths = UIAlertAction(title: "Kematian terbanyak", style: .default) { (_) in
            self.dataGlobal.sort(by: { $0.deaths > $1.deaths } )
            self.tableView.reloadData()
        }

        let actionActive = UIAlertAction(title: "Dalam perawatan terbanyak", style: .default) { (_) in
            self.dataGlobal.sort(by: { $0.active > $1.active } )
            self.tableView.reloadData()
        }

        let actionRecovered = UIAlertAction(title: "Sembuh terbanyak", style: .default) { (_) in
            self.dataGlobal.sort(by: { $0.recovered > $1.recovered } )
            self.tableView.reloadData()
        }

        alertVC.addAction(actionCases)
        alertVC.addAction(actionDeaths)
        alertVC.addAction(actionActive)
        alertVC.addAction(actionRecovered)
        alertVC.addAction(actionCancel)

        present(alertVC, animated: true, completion: nil)
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

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
