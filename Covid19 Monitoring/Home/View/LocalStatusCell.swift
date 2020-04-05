//
//  LocalStatusCell.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class LocalStatusCell: UICollectionViewCell {
        
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var lblStatus: UILabel!

    func parseData(data: StatusModel) {
        lblCounter.text = data.counter.toCommaSeperated()
        lblStatus.text = data.status.capitalized

        switch data.status {
        case CASES:
            lblCounter.textColor = .systemOrange
            lblStatus.textColor = .systemOrange
        case ACTIVE:
            lblCounter.textColor = .systemBlue
            lblStatus.textColor = .systemBlue
        case RECOVERED:
            lblCounter.textColor = .systemGreen
            lblStatus.textColor = .systemGreen
        case DEATHS:
            lblCounter.textColor = .systemRed
            lblStatus.textColor = .systemRed
        default:
            lblCounter.textColor = .lightGray
            lblStatus.textColor = .lightGray
        }
    }
}
