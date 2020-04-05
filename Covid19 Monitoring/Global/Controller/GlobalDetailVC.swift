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

    var dataCases = [StatusModel]()
    var dataDeaths = [StatusModel]()
    var dataActive = [StatusModel]()
    var dataRecovered = [StatusModel]()

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

        dataCases.append(StatusModel(counter: data.cases, status: CASES))
        dataCases.append(StatusModel(counter: data.todayCases, status: TODAY_CASES))

        dataDeaths.append(StatusModel(counter: data.deaths, status: DEATHS))
        dataDeaths.append(StatusModel(counter: data.todayDeaths, status: TODAY_DEATHS))

        dataActive.append(StatusModel(counter: data.active, status: ACTIVE))
        dataActive.append(StatusModel(counter: data.critical, status: CRITICAL))

        dataRecovered.append(StatusModel(counter: data.recovered, status: RECOVERED))
    }
}

extension GlobalDetailVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let x = 5, y = 5
        let width = tableView.frame.width
        let returnedView = UIView(frame: CGRect(x: x, y: y, width: Int(width), height: 20))
        let label = UILabel(frame: CGRect(x: x, y: y, width: Int(width), height: 20))

        switch section {
        case 0:
            returnedView.backgroundColor = .systemOrange
            label.text = CASES
        case 1:
            returnedView.backgroundColor = .systemRed
            label.text = DEATHS
        case 2:
            returnedView.backgroundColor = .systemBlue
            label.text = ACTIVE
        default:
            returnedView.backgroundColor = .systemGreen
            label.text = RECOVERED
        }

        returnedView.addSubview(label)
        return returnedView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dataCases.count
        case 1:
            return dataDeaths.count
        case 2:
            return dataActive.count
        default:
            return dataRecovered.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "GlobalDetailCell")
        var item: StatusModel

        switch indexPath.section {
        case 0 :
            item = dataCases[indexPath.row]
        case 1 :
            item = dataDeaths[indexPath.row]
        case 2 :
            item = dataActive[indexPath.row]
        default:
            item = dataRecovered[indexPath.row]
        }

        cell.textLabel?.text = item.status
        cell.detailTextLabel?.text = item.counter.toCommaSeperated()

        return cell
    }
}
