//
//  GlobalDetailVC.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class GlobalDetailVC: UIViewController {

    var data: CovidCountryModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        guard let data = data else {return}

        print(data.country)
    }
}
