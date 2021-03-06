//
//  TitleCell.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class TitleCell: UICollectionViewCell {
    
    @IBOutlet weak var lblLastUpdated: UILabel!

    func parseData(lastUpdated: String) {
        lblLastUpdated.text = lastUpdated
        lblLastUpdated.isHidden = lastUpdated.isEmpty
    }
}
