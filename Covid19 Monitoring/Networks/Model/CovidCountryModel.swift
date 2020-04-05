//
//  CovidCountryModel.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct CovidCountryModel: Codable {

    let country: String

    let cases: Int
    let todayCases: Int

    let deaths: Int
    let todayDeaths: Int

    let recovered: Int
    let critical: Int

    let active: Int

    let updated: TimeInterval
    let countryInfo: CountryInfo

    struct CountryInfo: Codable {
        let flag: String
    }
}
