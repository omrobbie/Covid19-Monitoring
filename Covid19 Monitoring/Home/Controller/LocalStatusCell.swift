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

    func parseData(data: LocalStatusModel) {
        lblCounter.text = "\(data.counter)"
        lblStatus.text = data.status.capitalized

        switch data.status {
        case POSITIF:
            lblCounter.textColor = .systemOrange
            lblStatus.textColor = .systemOrange
        case DALAM_PERAWATAN:
            lblCounter.textColor = .systemBlue
            lblStatus.textColor = .systemBlue
        case SEMBUH:
            lblCounter.textColor = .systemGreen
            lblStatus.textColor = .systemGreen
        case MENINGGAL:
            lblCounter.textColor = .systemRed
            lblStatus.textColor = .systemRed
        default:
            lblCounter.textColor = .lightGray
            lblStatus.textColor = .lightGray
        }
    }
}
