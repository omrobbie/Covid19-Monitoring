//
//  GlobalCell.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GlobalCell: UITableViewCell {

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblCases: UILabel!
    
    func parseData(data: CovidCountryModel) {
        lblCountry.text = data.country
        lblCases.text = "Jumlah kasus: \(data.cases.toCommaSeperated())"

        ApiService.shared.downloadImage(urlImage: data.countryInfo.flag) { (data) in
            self.imgFlag.image = UIImage(data: data)
            self.activityIndicator.isHidden = true
        }
    }
}
