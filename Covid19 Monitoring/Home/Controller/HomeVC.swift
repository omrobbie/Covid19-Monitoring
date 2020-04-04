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

    var dataLocalStatus = [LocalStatusModel]()

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
    }

    private func loadData() {
        ApiService.shared.getDataFromCountryName(countryName: "Indonesia") { (data) in
            self.dataLocalStatus.append(LocalStatusModel(counter: data.cases, status: POSITIF))
            self.dataLocalStatus.append(LocalStatusModel(counter: data.active, status: DALAM_PERAWATAN))
            self.dataLocalStatus.append(LocalStatusModel(counter: data.recovered, status: SEMBUH))
            self.dataLocalStatus.append(LocalStatusModel(counter: data.deaths, status: MENINGGAL))
            self.collectionView.reloadData()
            self.activityIndicator.isHidden = true
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return dataLocalStatus.count
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocalStatusCell", for: indexPath) as! LocalStatusCell
            cell.parseData(data: dataLocalStatus[indexPath.row])
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
        default:
            let size = collectionView.frame
            return CGSize(width: size.width, height: size.height)
        }
    }
}
