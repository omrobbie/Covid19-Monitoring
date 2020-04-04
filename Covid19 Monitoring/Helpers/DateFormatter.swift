//
//  DateFormat.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case shortDate = "dd/MM/yyyy"
    case shortDateTime = "MMM d, hh:mm"
    case longDate = "d MMM yyyy"
    case longDateTime = "d MMMM yyyy hh:mm"
}

extension Date {

    func toString(format: DateFormat = .shortDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}

extension TimeInterval {

    func toString(format: DateFormat = .shortDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: Date(timeIntervalSince1970: self / 1000))
    }
}
