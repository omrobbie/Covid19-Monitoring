//
//  CovidCountry.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct CovidCountryModel: Codable {

    let cases: Int
    let active: Int
    let recovered: Int
    let deaths: Int
    let updated: TimeInterval
    let country: String

    struct countryInfo {
        let flag: String
    }
}
