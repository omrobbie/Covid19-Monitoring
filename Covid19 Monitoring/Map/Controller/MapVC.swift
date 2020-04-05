//
//  MapVC.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var dataGlobal = [CovidCountryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    private func loadData() {
        ApiService.shared.getDataGlobalPerCountry { (data) in
            data.forEach { (item) in
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: item.countryInfo.lat, longitude: item.countryInfo.long)
                self.mapView.addAnnotation(annotation)
            }

            self.activityIndicator.isHidden = true
        }
    }
}
