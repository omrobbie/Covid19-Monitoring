//
//  GlobalDetailVC.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GlobalDetailVC: UIViewController {

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var data: CovidCountryModel?

    var dataDetail = [StatusModel]()

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
        guard let data = data else {return}

        lblCountry.text = data.country
        ApiService.shared.downloadImage(urlImage: data.countryInfo.flag) { (data) in
            self.imgFlag.image = UIImage(data: data)
            self.activityIndicator.isHidden = true
        }

        dataDetail.append(StatusModel(counter: data.cases, status: POSITIF))
        dataDetail.append(StatusModel(counter: data.active, status: DALAM_PERAWATAN))
        dataDetail.append(StatusModel(counter: data.recovered, status: SEMBUH))
        dataDetail.append(StatusModel(counter: data.deaths, status: MENINGGAL))
    }
}

extension GlobalDetailVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDetail.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "GlobalDetailCell")
        let item = dataDetail[indexPath.row]

        cell.textLabel?.text = item.status
        cell.detailTextLabel?.text = item.counter.toCommaSeperated()

        return cell
    }
}
