//
//  ApiService.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 04/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

class ApiService {

    static let shared = ApiService()

    private let BASE_URL = "https://corona.lmao.ninja/"
    private let COUNTRIES = "countries"
    private let ALL = "all"
}

extension ApiService {

    func getDataFromCountryName(countryName: String, completion: @escaping (CovidCountryModel) -> ()) {
        if let url = URL(string: BASE_URL + COUNTRIES + "/" + countryName) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    return
                }

                if let data = data {
                    let decoder = JSONDecoder()

                    if let json = try? decoder.decode(CovidCountryModel.self, from: data) {
                        DispatchQueue.main.async {
                            completion(json)
                        }
                    }
                }
            }.resume()
        }
    }

    func getDataGlobal(completion: @escaping (CovidWorldModel) -> ()) {
        if let url = URL(string: BASE_URL + ALL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    return
                }

                if let data = data {
                    let decoder = JSONDecoder()

                    if let json = try? decoder.decode(CovidWorldModel.self, from: data) {
                        DispatchQueue.main.async {
                            completion(json)
                        }
                    }
                }
            }.resume()
        }
    }
}
