//
//  WorldStatusCell.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class WorldStatusCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: CustomUIView!
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var lblStatus: UILabel!

    func parseData(data: StatusModel) {
        lblCounter.text = data.counter.toCommaSeperated()
        lblStatus.text = data.status

        switch data.status {
        case POSITIF:
            viewBackground.backgroundColor = .systemOrange
            lblStatus.textColor = .systemOrange
        case SEMBUH:
            viewBackground.backgroundColor = .systemGreen
            lblStatus.textColor = .systemGreen
        case MENINGGAL:
            viewBackground.backgroundColor = .systemRed
            lblStatus.textColor = .systemRed
        default:
            viewBackground.backgroundColor = .lightGray
            lblStatus.textColor = .lightGray
        }
    }
}
