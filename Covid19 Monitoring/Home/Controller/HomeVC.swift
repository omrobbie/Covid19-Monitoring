//
//  HomeVC.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 04/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var dataLocalStatus = [StatusModel]()
    var dataWorldStatus = [StatusModel]()

    var dataLocalStatusLastUpdated = ""
    var loadDataCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupRegisterNib()
        loadData()
    }

    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupRegisterNib() {
        collectionView.register(UINib(nibName: "TitleCell", bundle: nil), forCellWithReuseIdentifier: "TitleCell")
        collectionView.register(UINib(nibName: "LocalStatusCell", bundle: nil), forCellWithReuseIdentifier: "LocalStatusCell")
        collectionView.register(UINib(nibName: "SubTitleWorldCell", bundle: nil), forCellWithReuseIdentifier: "SubTitleWorldCell")
        collectionView.register(UINib(nibName: "WorldStatusCell", bundle: nil), forCellWithReuseIdentifier: "WorldStatusCell")
    }

    private func loadData() {
        ApiService.shared.getDataFromCountryName(countryName: "Indonesia") { (data) in
            self.dataLocalStatusLastUpdated = data.updated.toString(format: .longDateTime)
            self.dataLocalStatus.append(StatusModel(counter: data.cases, status: CASES))
            self.dataLocalStatus.append(StatusModel(counter: data.active, status: ACTIVE))
            self.dataLocalStatus.append(StatusModel(counter: data.recovered, status: RECOVERED))
            self.dataLocalStatus.append(StatusModel(counter: data.deaths, status: DEATHS))
            self.loadDataCheck()
        }

        ApiService.shared.getDataGlobal { (data) in
            self.dataWorldStatus.append(StatusModel(counter: data.cases, status: CASES))
            self.dataWorldStatus.append(StatusModel(counter: data.recovered, status: RECOVERED))
            self.dataWorldStatus.append(StatusModel(counter: data.deaths, status: DEATHS))
            self.loadDataCheck()
        }
    }

    private func loadDataCheck() {
        loadDataCount += 1

        if loadDataCount >= 2 {
            self.collectionView.reloadData()
            self.activityIndicator.isHidden = true
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return dataLocalStatus.count
        case 3:
            return dataWorldStatus.count
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as! TitleCell
            cell.parseData(lastUpdated: dataLocalStatusLastUpdated)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocalStatusCell", for: indexPath) as! LocalStatusCell
            cell.parseData(data: dataLocalStatus[indexPath.row])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubTitleWorldCell", for: indexPath) as! SubTitleWorldCell
            cell.lblSubTitle.isHidden = !activityIndicator.isHidden
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorldStatusCell", for: indexPath) as! WorldStatusCell
            cell.parseData(data: dataWorldStatus[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            let width = (collectionView.frame.width / 2) - 8
            let height = width / 1.2
            return CGSize(width: width, height: height)
        case 3:
            let width = (collectionView.bounds.width / 3) - 8
            return CGSize(width: width, height: 100)
        default:
            let size = collectionView.frame
            return CGSize(width: size.width, height: size.height)
        }
    }
}
